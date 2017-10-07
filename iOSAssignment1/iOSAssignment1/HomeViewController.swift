//
//  HomeViewController.swift
//  iOSAssignment1
//
//  Created by Campbell Brobbel on 8/8/17.
//  Copyright © 2017 CampbellRhys. All rights reserved.
//

import UIKit
import CoreData
class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, HomePageDelegate, WeatherNavBarDelegate, UIPopoverPresentationControllerDelegate, CitySelector, AddEventDelegate {

    var currentCity : Location = WeatherManager.shared.cities.first!
    let currentDate : Date = Date()
    
    /// Amount of seconds per day
    let daySeconds = 86400
    
    @IBOutlet weak var weatherDetailsView: WeatherDetailsView!
    @IBOutlet weak var eventTableView: UITableView!
    
    @IBOutlet weak var backgroundPageVCView: UIView!
    @IBOutlet weak var navBar: WeatherNavBar!
    @IBOutlet weak var loadingView : LoadingDataView!
    
    var currentPage = 0;
    var backgroundImagePageVC : HomePageViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.beginIgnoringInteractionEvents()
        testCoreData()
        
        self.eventTableView.dataSource = self
        self.eventTableView.delegate = self
        self.eventTableView.tableFooterView = UIView(frame: .zero)
        self.weatherDetailsView.isUserInteractionEnabled = false
        
        self.navBar.delegate = self
        self.backgroundImagePageVC = self.childViewControllers[0] as? HomePageViewController
        self.backgroundImagePageVC?.homeDelegate = self
        self.view.addSubview(loadingView)
        self.updateLoadScreenConstraints()
        self.loadingView.startAnimatingIndicator()
        UIApplication.shared.statusBarStyle = .lightContent
        
    }
    
    func testCoreData() {
        print("TESTING CORE DATA ===============================")
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer.viewContext
//        let location = EventLocation(context: context)
//        location.name = "Hoyts"
//        location.address = "Eastland"
//        location.city = "Ringwood"
//        location.country = "AU"
//        
//        let event = WeatherEvent(context: context)
//        event.title = "First Event Title"
//        event.dateTime = NSDate()
//        event.eventLocation = location
//        delegate.saveContext()
        
        do {
            let events : [WeatherEvent] = try context.fetch(WeatherEvent.fetchRequest())
            print("Printing Events")
            for event in events {
                print(event.asString())
            }
            
        }
        catch {
                
        }
        print("=================================================")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("Before Did Appear")
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        EventManager.shared.loadEventsFrom(context: context)
        print("Weather Manager Cities After Events Init: \(WeatherManager.shared.userCities.count)")
        
        
        let sem = DispatchSemaphore(value: 0)
        WeatherManager.shared.updateAllCities {
            EventManager.shared.updateAllEventForecasts()
            self.navBar.cityButton.titleLabel?.text = "\(currentCity.city!)"
            updateWeatherViewFrom(index: 0)
            self.eventTableView.reloadData()
            //self.weatherDetailsView.isUserInteractionEnabled = true
            self.updateBackgroundImagesWith(city: currentCity)
            
            self.loadingView.hideView()

            //self.loadingView.removeFromSuperview()
            UIApplication.shared.endIgnoringInteractionEvents()
            sem.signal()
        }
        sem.wait()
        
        for city in WeatherManager.shared.cityWeatherForecasts {
            print("\(city.location.city!), \(city.location.country!)")
        }
        print("After Did Appear")
    }
    // MARK:- Table View Data Source/Delegate
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let day =  currentDate.addingTimeInterval(TimeInterval(currentPage * self.daySeconds))
        return EventManager.shared.eventsFor(day: day).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let day =  currentDate.addingTimeInterval(TimeInterval(currentPage * self.daySeconds))
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventDetailsCell")! as! EventDetailsTableViewCell
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do {
            let events : [WeatherEvent] =  try context.fetch(WeatherEvent.fetchRequest())
            for event in events {
                print(event.asString())
            }
        }
        catch {
            print(error.localizedDescription)
        }
        
        // Needs Fixing
        cell.updateCellWithEvent(event: EventManager.shared.eventsFor(day: day)[indexPath.row])
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.dequeueReusableCell(withIdentifier: "eventDetailsCell")!.bounds.height
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func pageSwitchedTo(index: Int) {
        updateWeatherViewFrom(index: index)
        self.currentPage = index
        self.eventTableView.reloadData()
    }
    
    private func updateWeatherViewFrom(index : Int) {
        self.weatherDetailsView.pageControl.currentPage = index
        
        var cityWeatherManager : CityWeatherForecastManager?
        for cityForecast in WeatherManager.shared.cityWeatherForecasts {
            if cityForecast.location.city == self.currentCity.city && cityForecast.location.country == self.currentCity.country {
                cityWeatherManager = cityForecast
            }
        }
        
        var forecast : DailyWeather = (WeatherManager.shared.forecastsFor(location: currentCity)?.first)!
        if Calendar.current.isDate(cityWeatherManager!.dailyForecasts[0].date, inSameDayAs: Date()) {
            forecast = cityWeatherManager!.dailyForecasts[index]
        }
        else {
            if index != 0 {
               forecast = cityWeatherManager!.dailyForecasts[index-1]
            }
        }
        
        let todaysDate = Date()
        let date = todaysDate.addingTimeInterval(TimeInterval(daySeconds * index))

        let day = Calendar.current.component(Calendar.Component.day, from: date)
        let month = Calendar.current.component(Calendar.Component.month, from: date)
        let year = Calendar.current.component(Calendar.Component.year, from: date)
        let weekday = Calendar.current.component(Calendar.Component.weekday, from: date)
        let weekdayString = self.getWeekdayFrom(number: weekday)
        
        if Calendar.current.isDate(date, inSameDayAs: todaysDate) {
            self.weatherDetailsView.timeLabel.text = "Today (\(weekdayString))"

        }
        else {
            self.weatherDetailsView.timeLabel.text = "\(weekdayString) \(day)/\(month)/\(year)"

        }
        
        if forecast != nil {
            self.weatherDetailsView.minTempLabel.text = "\(Int(forecast.minTemp))℃"
            self.weatherDetailsView.maxTempLabel.text = "\(Int(forecast.maxTemp!))℃"
            self.weatherDetailsView.chanceOfRainLabel.text = forecast.forecasts.first!.weatherType.rawValue
        }
        else {
            self.weatherDetailsView.minTempLabel.text = ""
            self.weatherDetailsView.maxTempLabel.text = ""
            self.weatherDetailsView.chanceOfRainLabel.text = ""
        }
        
    }
    
    // MARK: - Weather Nav Bar Delegate
    
    func todayButtonPressed() {
        updateWeatherViewFrom(index: 0)
        self.currentPage = 0
        self.backgroundImagePageVC?.jumptoPage(index: 0)
        self.eventTableView.reloadData()
    }
    
    func cityButtonPressed() {
        
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "citySelectorSegue" {
            let dest = segue.destination as! CitySelectorViewController
            dest.citySelector = self
        }
        else if segue.identifier == "eventDetailsSegue" {
            
            let nav = segue.destination as! UINavigationController
            let dest = nav.viewControllers.first as! EventDetailsViewController
            let cell = sender as! EventDetailsTableViewCell
            dest.event = cell.event
        }
        else if segue.identifier == "addEventSegue" {
            
            let nav = segue.destination as! UINavigationController
            let dest = nav.viewControllers.first as! AddEventViewController
            dest.delegate = self
        }
        
    }
    
    func cityChange(city: Location) {
        self.currentCity = city
        self.updateWeatherViewFrom(index: 0)
        self.updateBackgroundImagesWith(city: city)
        self.navBar.cityButton.titleLabel?.text = "\(city.city!) ⌵"
        self.backgroundImagePageVC?.jumptoPage(index: 0)
        self.currentPage = 0
        self.eventTableView.reloadData()

    }
    
    func eventAdded(event: Event) {
        self.eventTableView.reloadData()
    }
    
    func updateBackgroundImagesWith(city : Location) {
        let forecast = WeatherManager.shared.forecastsFor(location: city)
        
        for number in 0...(self.backgroundImagePageVC?.homeViewControllers)!.count-1 {
            let vc = self.backgroundImagePageVC?.homeViewControllers[number]
            vc!.weatherType = forecast![number].forecasts.first?.weatherType
        }
        
        let vc = self.backgroundImagePageVC?.homeViewControllers[(self.backgroundImagePageVC?.currentPageIndex)!]
        vc?.updateBackgroundImage()
    }
    
    func getWeekdayFrom(number : Int) -> String {
        print("Weekday Number: \(number)")
        switch number {
        case 2:
            return "Monday"
        case 3:
            return "Tuesday"
        case 4:
            return "Wednesday"
        case 5:
            return "Thursday"
        case 6:
            return "Friday"
        case 7:
            return "Saturday"
        case 1:
            return "Sunday"
        default:
            return ""
        }
    }
    
    func updateLoadScreenConstraints() {
        // Get the superview's layout
        
        self.loadingView.translatesAutoresizingMaskIntoConstraints = false
        let leading = NSLayoutConstraint(item: self.loadingView, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1.0, constant: 0.0)
        let trailing = NSLayoutConstraint(item: self.loadingView, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1.0, constant: 0.0)
        let top = NSLayoutConstraint(item: self.loadingView, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1.0, constant: 0.0)
        let bottom = NSLayoutConstraint(item: self.loadingView, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1.0, constant: 0.0)
      
        self.view.addConstraints([leading, trailing, top, bottom])
        self.view.layoutIfNeeded()
    }
}


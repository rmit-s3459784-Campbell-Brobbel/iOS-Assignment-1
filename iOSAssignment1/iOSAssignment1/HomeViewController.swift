//
//  HomeViewController.swift
//  iOSAssignment1
//
//  Created by Campbell Brobbel on 8/8/17.
//  Copyright © 2017 CampbellRhys. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, HomePageDelegate, WeatherNavBarDelegate, UIPopoverPresentationControllerDelegate, CitySelector {

    var currentCity : Location = WeatherManager.shared.cities.first!

    
    @IBOutlet weak var weatherDetailsView: WeatherDetailsView!
    @IBOutlet weak var eventTableView: UITableView!
    
    @IBOutlet weak var backgroundPageVCView: UIView!
    @IBOutlet weak var navBar: WeatherNavBar!
    var currentPage = 0;
    var backgroundImagePageVC : HomePageViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.eventTableView.dataSource = self
        self.eventTableView.delegate = self
        self.weatherDetailsView.isUserInteractionEnabled = false
        self.navBar.cityButton.titleLabel?.text = "\(currentCity.city!)"
        updateWeatherViewFrom(index: 0)
        self.navBar.delegate = self
        self.backgroundImagePageVC = self.childViewControllers[0] as? HomePageViewController
        self.backgroundImagePageVC?.homeDelegate = self
        
        UIApplication.shared.statusBarStyle = .lightContent
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK:- Table View Data Source/Delegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let day =  WeatherManager.shared.cityWeatherForecasts.first!.dailyForecasts[self.currentPage].date
        print("\(EventManager.shared.eventsFor(day: day).count)")
        return EventManager.shared.eventsFor(day: day).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let day =  WeatherManager.shared.cityWeatherForecasts.first!.dailyForecasts[(self.backgroundImagePageVC?.currentPageIndex)!].date
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventDetailsCell")! as! EventDetailsTableViewCell
        
        
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
        print("Page Switched")
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
        
        let forecast = cityWeatherManager!.dailyForecasts[index]
        let date = forecast.date
        let day = Calendar.current.component(Calendar.Component.day, from: date)
        let month = Calendar.current.component(Calendar.Component.month, from: date)
        let year = Calendar.current.component(Calendar.Component.year, from: date)
        let weekday = Calendar.current.component(Calendar.Component.weekday, from: date)
        let todaysDate = Date()
        
        if Calendar.current.isDate(date, inSameDayAs: todaysDate) {
            self.weatherDetailsView.timeLabel.text = "Today"

        }
        else {
            self.weatherDetailsView.timeLabel.text = "\(day)/\(month)/\(year)"

        }
        
        self.weatherDetailsView.minTempLabel.text = "\(Int(forecast.minTemp!))℃"
        self.weatherDetailsView.maxTempLabel.text = "\(Int(forecast.maxTemp!))℃"
        self.weatherDetailsView.chanceOfRainLabel.text = forecast.forecasts.first!.weatherType.rawValue
    }
    
    // MARK: - Weather Nav Bar Delegate
    
    func todayButtonPressed() {
        print("Today Button Pressed")
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
            print(dest.event)
        }
        
    }
    
    func cityChange(city: Location) {
        self.currentCity = city
        self.updateWeatherViewFrom(index: 0)
        self.navBar.cityButton.titleLabel?.text = "\(city.city!) ⌵"
        self.backgroundImagePageVC?.jumptoPage(index: 0)
        self.currentPage = 0
        self.eventTableView.reloadData()

    }
}



//
//  AddEventViewController.swift
//  iOSAssignment1
//
//  Created by Campbell Brobbel on 27/9/17.
//  Copyright © 2017 CampbellRhys. All rights reserved.
//

import UIKit
import MapKit

protocol AddEventDelegate {
    func eventAdded(event : Event)
}
class AddEventViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, MapSearchProtocol {

    var mapItem : MKMapItem?
    var delegate : AddEventDelegate?
    var sectionTitles : [String] = ["Title", "Date", "Location"]
    @IBOutlet weak var tableView : UITableView!
    
    @IBAction func dismissView() {
        dismiss(animated: true, completion: nil)
    }
    
    /// Validates all inputs and then adds an event while also downloading the weather data for the city.
    @IBAction func saveEvent() {
       
        if mapItem == nil || self.getTitle() == "" {
            var message = ""
            
            if mapItem == nil && self.getTitle() == "" {
                message = "You need to enter a title and location."
            }
            else if mapItem != nil && self.getTitle() == ""{
                message = "You need to enter a title."
            }
            else {
                message = "You need to enter a location."
            }
            self.showAlert(title: "Error", message: message)
        }
        else {
            let event = Event(eventTitle: self.getTitle(), eventDateTime: self.getDate(), location: self.getLocation())
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            
            let newLocation = EventLocation(context: context)
            newLocation.name = self.mapItem!.name!
            newLocation.address = self.mapItem!.placemark.title!
            let itemLoc = self.getLocation()
            newLocation.city = itemLoc.city
            newLocation.country = itemLoc.country
            
            let newEvent = WeatherEvent(context: context)
            newEvent.title = self.getTitle()
            newEvent.eventLocation = newLocation
            newEvent.dateTime = self.getDate() as NSDate
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            WeatherManager.shared.addUserLocation(location: event.location) {
                event.updateForecast()
            }
            
            EventManager.shared.addEvent(event: event)
            self.delegate?.eventAdded(event: event)
            self.dismissView()
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.tableFooterView = UIView(frame: .zero)
        self.tableView.keyboardDismissMode = .onDrag
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Table View Data Source/Delegate

    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 2 && self.mapItem != nil {
            return 2
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "datePickerCell") as! EventDatePickerTableViewCell
            cell.datePicker.setValue(UIColor.white, forKey: "textColor")
            cell.datePicker.perform("setHighlightsToday:", with: UIColor.white)
            cell.datePicker.minimumDate = Date()
            
            return cell
        }
        if indexPath.section == 2 {
            
            if indexPath.row == 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "mapViewCell") as! EventLocationTableViewCell
                cell.updateLocationWith(mapItem: mapItem!)
                return cell
            }
            let cell = tableView.dequeueReusableCell(withIdentifier: "locationCell")!
            cell.textLabel?.text = mapItem?.name ?? "No Location"
            cell.detailTextLabel?.text = mapItem?.placemark.title ?? ""
            
            
            
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "infoCell") as! EventTextFieldTableViewCell
        cell.textField.placeholder = "Basketball Game"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
            
        // Date Picker Cell
        case 1:
            return 200
        default:
            break
        }
        
        if indexPath.section == 2 && indexPath.row == 1 {
            return 200
        }
        return 40
        
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 2 {
            return 0
        }
        return 5
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 40
    }
    func mapItemSelected(mapItem: MKMapItem) {
        print("Map Item Selected")
        print(mapItem.name ?? "No Name")
        self.mapItem = mapItem
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 40))
        let label = UILabel(frame: CGRect(x: 14, y: 0, width: tableView.frame.width-20, height: 40))
        label.text = sectionTitles[section]
        label.textColor = .white
        label.font = UIFont(name: "Avenir", size: 25)
        label.center.y = view.center.y
        
        view.addSubview(label)
        view.backgroundColor = .clear
        return view
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 5))
        view.backgroundColor = .clear
        return view
    }
    //MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "searchMapSegue" {
            let dest = segue.destination as! EventLocationSearchViewController
            dest.delegate = self
        }
    }
    
    //MARK: - Other Functions
    

    /// Gets the event title from the appropriate cell.
    private func getTitle() -> String {
        let cell = self.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! EventTextFieldTableViewCell
        return cell.textField.text!
    }
    
    /// Gets the event date from the appropriate cell.
    private func getDate() -> Date {
        let cell = self.tableView.cellForRow(at: IndexPath(row: 0, section: 1)) as! EventDatePickerTableViewCell
        return cell.datePicker.date
    }
    
    /// Gets the event location from the appropriate cell.
    private func getLocation() -> Location {
        
        let locationName : String = (self.mapItem?.name) ?? ""
        let locationTitle : String = self.mapItem?.placemark.title ?? ""
        let locationCity : String = self.mapItem?.placemark.addressDictionary?["City"] as! String 
        let locationCountry : String = self.mapItem?.placemark.addressDictionary!["CountryCode"] as? String ?? ""
        
        return Location(name: locationName,  address: locationTitle, city: locationCity, country: locationCountry)
        
    }

    /// Displays an alert to the user if the correct information is not entered properly.
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    

}

//
//  CitySelectorViewController.swift
//  iOSAssignment1
//
//  Created by Campbell Brobbel on 8/8/17.
//  Copyright © 2017 CampbellRhys. All rights reserved.
//

import UIKit

/// A protocol for updating other controllers with information about the selected city.
protocol CitySelector {
    func cityChange(city : Location)
}
class CitySelectorViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, CityNavBarDelegate {

    @IBOutlet weak var cityNavBar: CityNavBar!
    @IBOutlet weak var cityTableView: UITableView!
    
    var citySelector : CitySelector?
    
    // MARK:- View Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cityTableView.dataSource = self
        self.cityTableView.delegate = self
        self.cityNavBar.delegate = self
        // Do any additional setup after loading the view.
    }

    // MARK:- CityNavBar Delegate Methods

    func cancelButtonPressed() {
        self.dismiss(animated: true, completion: nil)
    }

    // MARK:- Table View Data Source/Delegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return WeatherManager.shared.cities.count
        }
        return WeatherManager.shared.userCities.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Major Cities"
        }
        return "User Cities"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var location : Location!
        if indexPath.section == 0 {
            location = WeatherManager.shared.cities[indexPath.row]
        }
        else {
           location = WeatherManager.shared.userCities[indexPath.row]
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityCell")! as! CityTableViewCell
        cell.cityLabel.text = "\(location.city!), \(location.country!)"
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            self.citySelector?.cityChange(city: WeatherManager.shared.cities[indexPath.row])
        }
        else {
            self.citySelector?.cityChange(city: WeatherManager.shared.userCities[indexPath.row])
        }
        tableView.deselectRow(at: indexPath, animated: true)
        dismiss(animated: true, completion: nil)
    }
}

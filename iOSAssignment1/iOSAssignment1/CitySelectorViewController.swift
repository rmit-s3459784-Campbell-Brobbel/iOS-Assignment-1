//
//  CitySelectorViewController.swift
//  iOSAssignment1
//
//  Created by Campbell Brobbel on 8/8/17.
//  Copyright © 2017 CampbellRhys. All rights reserved.
//

import UIKit


protocol CitySelector {
    func cityChange(city : Location)
}
class CitySelectorViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, CityNavBarDelegate {

    @IBOutlet weak var cityNavBar: CityNavBar!
    @IBOutlet weak var cityTableView: UITableView!
    
    var citySelector : CitySelector?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cityTableView.dataSource = self
        self.cityTableView.delegate = self
        self.cityNavBar.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func cancelButtonPressed() {
        self.dismiss(animated: true, completion: nil)
    }

    // MARK:- Table View Data Source/Delegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return WeatherManager.shared.cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let location = WeatherManager.shared.cities[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityCell")! as! CityTableViewCell
        cell.cityLabel.text = "\(location.city!), \(location.country!)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(WeatherManager.shared.cities[indexPath.row])
        self.citySelector?.cityChange(city: WeatherManager.shared.cities[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    
}

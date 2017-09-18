//
//  EventWeatherDetailsViewController.swift
//  iOSAssignment1
//
//  Created by Campbell Brobbel on 27/8/17.
//  Copyright © 2017 CampbellRhys. All rights reserved.
//

import UIKit

class EventWeatherDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CityNavBarDelegate {
   
    var weatherForecast : WeatherForecast?
    
    @IBOutlet weak var navBar : CityNavBar!
    @IBOutlet weak var tableView: UITableView!

   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.navBar.delegate = self
        // Do any additional setup after loading the view.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "weatherImageCell")! as! WeatherImageTableViewCell
            cell.weatherImageView.image = self.weatherForecast?.forecastImage
            
            return cell
            
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "weatherDetailCell")!
        
        switch indexPath.row {
        case 1:
            cell.textLabel?.text = "City"
            cell.detailTextLabel?.text = "\(self.weatherForecast!.city)"
        case 2:
            cell.textLabel?.text = "Country"
            cell.detailTextLabel?.text = "\(self.weatherForecast!.country)"
        case 3:
            cell.textLabel?.text = "Temperature"
            cell.detailTextLabel?.text = "\(self.weatherForecast!.temp)℃"
        case 4:
            cell.textLabel?.text = "Weather Type"
            cell.detailTextLabel?.text = "\(self.weatherForecast!.weatherType.rawValue)"
        case 5:
            cell.textLabel?.text = "Desc"
            cell.detailTextLabel?.text = "\(self.weatherForecast!.weatherDescription)"
        default:
            break
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
   
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 100
        }
        return 45   
    }
    func cancelButtonPressed() {
        self.dismiss(animated: true, completion: nil)
    }
    
}

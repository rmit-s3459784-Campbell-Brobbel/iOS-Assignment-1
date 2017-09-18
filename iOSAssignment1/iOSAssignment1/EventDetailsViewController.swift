//
//  EventDetailsViewController.swift
//  iOSAssignment1
//
//  Created by Campbell Brobbel on 16/8/17.
//  Copyright © 2017 CampbellRhys. All rights reserved.
//

import UIKit

class EventDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CityNavBarDelegate {
    
    var event : Event?
    var sectionTitles : [String] = ["Location", "Time", "Other Details"]
    
    @IBOutlet weak var eventDetailsTableView: UITableView!
    @IBOutlet weak var navBar : CityNavBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.eventDetailsTableView.dataSource = self
        self.eventDetailsTableView.delegate = self
        self.navBar.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "l"
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return 1
        case 1:
            return 2
        case 2:
            return 1
        default:
            return 1
        }
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell : UITableViewCell!
        
        
        if indexPath.section == 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: "eventTitleCell")!
            cell.textLabel?.text = "\(event!.eventTitle)"
            return cell
        }
        
       
        
        
        
        if indexPath.section == 1 {
            cell = tableView.dequeueReusableCell(withIdentifier: "eventDetailCell")!
            switch indexPath.row {
            case 0:
                cell.textLabel?.text = "City"
                cell.detailTextLabel?.text = "\(event!.location.city!)"

            case 1:
                cell.textLabel?.text = "Country"
                cell.detailTextLabel?.text = "\(event!.location.country!)"
                
            default:
                break
            }
            
        }
        
        else if indexPath.section == 2 {
            cell = tableView.dequeueReusableCell(withIdentifier: "eventDetailCell")!
            let date = Calendar.current.component(Calendar.Component.day, from: (event?.eventDateTime)!)
            let month = Calendar.current.component(Calendar.Component.month, from: (event?.eventDateTime)!)
            let year = Calendar.current.component(Calendar.Component.year, from: (event?.eventDateTime)!)
            let hour = Calendar.current.component(Calendar.Component.hour, from: (event?.eventDateTime)!)
            let minute = Calendar.current.component(Calendar.Component.minute, from: (event?.eventDateTime)!)
            if indexPath.row == 0{
                cell.textLabel?.text = "Date"
                cell.detailTextLabel?.text = "\(date)/\(month)/\(year)"
 
            }
            else {
                cell.textLabel?.text = "Time"
                cell.detailTextLabel?.text = "\(hour):\(minute)"
            }
        }
        
        else {
            cell = tableView.dequeueReusableCell(withIdentifier: "eventDetailCellWithDisclosure")!
            cell.textLabel?.text = "Temperature"
            cell.detailTextLabel?.text = "\(Int(self.event!.forecast!.temp))℃"
        }
        
        return cell
        
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 65
        }
        
        return 45
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let frame = CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 30)
        let view = UIView(frame: frame)
        view.backgroundColor = .clear
        let labelFrame = CGRect(x: 16, y: 0, width: tableView.bounds.width-16, height: 30)

        let label = UILabel(frame: labelFrame)
        if section > 0 {
            label.text = sectionTitles[section-1]
        }
        label.textColor = .white
        label.font = UIFont(name: "Avenir", size: 18)
        view.addSubview(label)
        return view
    }
    
    
    func cancelButtonPressed() {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "eventWeatherSegue" {
            let dest = segue.destination as! EventWeatherDetailsViewController
            dest.weatherForecast = self.event?.forecast!
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let frame = CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 30)
        let view = UIView(frame: frame)
        view.backgroundColor = .clear
        return view
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return "nothing"
    }
}

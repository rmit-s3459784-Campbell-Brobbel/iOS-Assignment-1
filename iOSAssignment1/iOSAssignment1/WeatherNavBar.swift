//
//  WeatherNavBar.swift
//  iOSAssignment1
//
//  Created by Campbell Brobbel on 22/8/17.
//  Copyright © 2017 CampbellRhys. All rights reserved.
//

import UIKit

/// Notifies delegate objects about interactions with the WeatherNavBar
protocol WeatherNavBarDelegate {
    func todayButtonPressed()
    func cityButtonPressed()
    
}

class WeatherNavBar: UIVisualEffectView {

    // MARK: - IBOutlets

    @IBOutlet weak var todayButton: UIButton!
    @IBOutlet weak var dateLabel : UILabel!
    @IBOutlet weak var cityButton : UIButton!

    var delegate : WeatherNavBarDelegate?
    
    
    // MARK: - WeatherNavBarDelegateMethods
    
    @IBAction func cityButtonPressed(sender: Any) {
        self.delegate?.cityButtonPressed()
    }
    
    @IBAction func todayButtonPressed(sender: Any) {
        self.delegate?.todayButtonPressed()
    }
    
    // MARK: - View Methods
    
    override func draw(_ rect: CGRect) {
        let date = Date()
        let day = Calendar.current.component(Calendar.Component.day, from: date)
        let month = Calendar.current.component(Calendar.Component.month, from: date)
        let year = Calendar.current.component(Calendar.Component.year, from: date)
        self.cityButton.titleLabel?.textAlignment = .center
        self.dateLabel.text = "\(day)/\(month)/\(year)"
        
    }
    
    
 

}

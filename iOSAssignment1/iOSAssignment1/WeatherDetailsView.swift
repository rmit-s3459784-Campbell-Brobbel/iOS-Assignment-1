//
//  WeatherDetailsView.swift
//  iOSAssignment1
//
//  Created by Campbell Brobbel on 9/8/17.
//  Copyright © 2017 CampbellRhys. All rights reserved.
//

import UIKit

class WeatherDetailsView: UIView {
    
    /// For displaying a day's minimum temperature.
    @IBOutlet weak var minTempLabel: UILabel!
    
    /// For displaying a day's maximum temperature.
    @IBOutlet weak var maxTempLabel: UILabel!
    
    /// For displaying a for displaying other info regarding daily weather.
    @IBOutlet weak var chanceOfRainLabel: UILabel!
    
    /// For displaying information regarding the date.
    @IBOutlet weak var timeLabel: UILabel!
    
    /// Displays what page of the background page controller we are on.
    @IBOutlet weak var pageControl: UIPageControl!
    
   
}

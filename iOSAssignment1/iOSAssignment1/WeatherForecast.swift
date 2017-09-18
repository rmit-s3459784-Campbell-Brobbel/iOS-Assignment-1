//
//  WeatherForecast.swift
//  iOSAssignment1
//
//  Created by Campbell Brobbel on 15/8/17.
//  Copyright © 2017 CampbellRhys. All rights reserved.
//

import Foundation
import UIKit

public class WeatherForecast {
    
    var city : String
    var country : String
    var dateTime : Date
    var temp : Float
    var weatherType : WeatherType
    var weatherDescription : String
    var forecastImage: UIImage
    
    init(city: String, country: String, dateTime: Date, temp: Float, weatherType: WeatherType, weatherDescription: String) {
        self.city = city
        self.country = country
        self.dateTime = dateTime
        self.temp = temp
        self.weatherType = weatherType
        self.weatherDescription = weatherDescription
        
        switch weatherType {
        case .Clear:
            self.forecastImage = #imageLiteral(resourceName: "sunny")
        case .Rain:
            self.forecastImage = #imageLiteral(resourceName: "raining")
        default:
            self.forecastImage = #imageLiteral(resourceName: "clouds")
            
        }
    }

    init(city : String, country : String, forecastDictionary : NSDictionary) {
        self.city = city
        self.country = country
        let interval = TimeInterval(forecastDictionary.value(forKey: "dt") as! Float)
        self.dateTime = Date(timeIntervalSince1970: interval)
        let mainDictionary = forecastDictionary.value(forKey: "main") as! NSDictionary
        self.temp =  mainDictionary.value(forKey: "temp") as! Float
        let weatherArray = forecastDictionary.value(forKey: "weather") as! NSArray
        let weatherDictionary = weatherArray.firstObject as! NSDictionary
        self.weatherType = WeatherType(rawValue: weatherDictionary.value(forKey: "main") as! String)!
        self.weatherDescription = weatherDictionary.value(forKey: "description") as! String
        
        print(self.weatherType)
        switch self.weatherType {
        case .Clear:
            self.forecastImage = #imageLiteral(resourceName: "sunny")
        case .Rain:
            self.forecastImage = #imageLiteral(resourceName: "raining")
        default:
            self.forecastImage = #imageLiteral(resourceName: "clouds")

        }
    }
    
    public func toString() -> String {
        
        return "City : \(self.city), Country : \(self.country), Date : \(dateToString(date: self.dateTime)), Temp : \(self.temp)"
    }
    
    public func dateToString(date : Date) -> String {
        
        let monthNumber = Calendar.current.component(Calendar.Component.month, from: date)
        var monthString : String!
        
        switch monthNumber {
        case 1:
            monthString = "Jan"
            break
        case 2:
            monthString = "Feb"
            break
        case 3:
            monthString = "Mar"
            break
        case 4:
            monthString = "Apr"
            break
        case 5:
            monthString = "May"
            break
        case 6:
            monthString = "Jun"
            break
        case 7:
            monthString = "Jul"
            break
        case 8:
            monthString = "Aug"
            break
        case 9:
            monthString = "Sep"
            break
        case 10:
            monthString = "Oct"
            break
        case 11:
            monthString = "Nov"
            break
        case 12:
            monthString = "Dec"
            break

        default: break
            
        }
        
        let dayString = "\(Calendar.current.component(Calendar.Component.day, from: date))"
        
        return "\(monthString!) \(dayString)"
    }
}

public enum WeatherType : String {
    
    case Clear = "Clear"
    case Rain = "Rain"
    case Clouds = "Clouds"
    
}

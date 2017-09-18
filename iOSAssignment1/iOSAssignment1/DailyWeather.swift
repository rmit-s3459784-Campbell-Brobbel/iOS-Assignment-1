//
//  DailyWeather.swift
//  iOSAssignment1
//
//  Created by Campbell Brobbel on 15/8/17.
//  Copyright © 2017 CampbellRhys. All rights reserved.
//

import Foundation

class DailyWeather {
    
    var minTemp : Float!
    var maxTemp : Float!
    var date  : Date
    var forecasts : [WeatherForecast] = []
    public private(set) var city : String
    public private(set) var country : String
    
    init(dailyWeatherDictionary : NSDictionary) {
      
        self.city = dailyWeatherDictionary.value(forKey: "city") as! String
        self.country = dailyWeatherDictionary.value(forKey: "country") as! String
        let forecastArray = dailyWeatherDictionary.value(forKey: "forecasts") as! [NSDictionary]
        let interval = TimeInterval(forecastArray.first!.value(forKey: "dt") as! Int)
        self.date = Date(timeIntervalSince1970: interval)
        
        for forecastDictionary in forecastArray {
            let weatherForecast = WeatherForecast(city: city, country: country, forecastDictionary: forecastDictionary)
            if self.minTemp == nil {
                self.minTemp = weatherForecast.temp
            }
            else if weatherForecast.temp < self.minTemp {
                self.minTemp = weatherForecast.temp
            }
            if self.maxTemp == nil {
                self.maxTemp = weatherForecast.temp
            }
            else if weatherForecast.temp > self.maxTemp {
                self.maxTemp = weatherForecast.temp
            }
            forecasts.append(weatherForecast)
            
        }
    }
    
    public func getCity() -> String {
        return self.city
    }
    
    public func getCountry() -> String {
        return self.country
    }
    
    public func getMinMaxTemp() -> (min: Float, max: Float) {
      
        
        return (min: self.minTemp!, max: self.maxTemp!)
    }
    
    public func toString() -> String {
        let day = Calendar.current.component(Calendar.Component.day, from: self.date)
        let month = Calendar.current.component(Calendar.Component.month, from: self.date)
        let hour = Calendar.current.component(Calendar.Component.hour, from: self.date)
        let minute = Calendar.current.component(Calendar.Component.minute, from: self.date)
        return "Date: \(day)/\(month), Time: \(hour):\(minute) Location: \(self.city)/\(self.country), minTemp: \(self.minTemp) maxTemp: \(self.maxTemp)"
        
    }
    

    
}

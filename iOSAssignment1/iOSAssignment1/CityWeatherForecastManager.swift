//
//  CityWeatherForecastManager.swift
//  iOSAssignment1
//
//  Created by Campbell Brobbel on 16/8/17.
//  Copyright © 2017 CampbellRhys. All rights reserved.
//

import Foundation

public class CityWeatherForecastManager {
    
    private(set) var location : Location = Location.init()
    
    var dailyForecasts : [DailyWeather] = []
    
    init(cityWeatherForecastDictionary : NSDictionary) {
        let locationDictionary = cityWeatherForecastDictionary.value(forKey: "city") as! NSDictionary
        self.location.city = locationDictionary.value(forKey: "name") as! String
        self.location.country = locationDictionary.value(forKey: "country") as! String
        
        
        let dailyForecastList = cityWeatherForecastDictionary.value(forKey: "list") as! NSArray
        createDailyForecasts(dailyForecastList: dailyForecastList)
        
    }
    
    private func createDailyForecasts(dailyForecastList : NSArray) {
        
        var forecastDictionaries : [NSDictionary] = []
        
        for forecast in dailyForecastList {
            
            let forecastDictionary = forecast as! NSDictionary
              
            // If the forecasts array is empty
            if forecastDictionaries.count == 0 {
                forecastDictionaries.append(forecastDictionary)
            }
            else {
                
                let interval1 = TimeInterval(forecastDictionary.value(forKey: "dt") as! Int)
                let date1 = Date(timeIntervalSince1970: interval1)
                
                let interval2 = TimeInterval(forecastDictionaries.first!.value(forKey: "dt") as! Int)
                let date2 = Date(timeIntervalSince1970: interval2)
                
                // If the date of the forecast is the same as the forecasts inside the array, continue adding the forecasts into the array.
                let day1 = Calendar.current.component(Calendar.Component.day, from: date1)
                let day2 = Calendar.current.component(Calendar.Component.day, from: date2)
                
                
                if day1 == day2 {
                    forecastDictionaries.append(forecastDictionary)
                }
                else {
                    // Otherwise create a new daily forecast and reset forecast dictionary array.

                    let dailyForecastDictionary : NSDictionary = ["city" : self.location.city, "country" : self.location.country, "forecasts" : forecastDictionaries]
                    let dailyForecast = DailyWeather(dailyWeatherDictionary: dailyForecastDictionary)
                    self.dailyForecasts.append(dailyForecast)
                    
                    // Clear the forecast array.
                    forecastDictionaries = []

                }
                
            }
            
            
        }
        
        let dailyForecastDictionary : NSDictionary = ["city" : self.location.city, "country" : self.location.country, "forecasts" : forecastDictionaries]
        if forecastDictionaries.count > 0 {
            let dailyForecast = DailyWeather(dailyWeatherDictionary: dailyForecastDictionary)
            self.dailyForecasts.append(dailyForecast)

        }
    }
}

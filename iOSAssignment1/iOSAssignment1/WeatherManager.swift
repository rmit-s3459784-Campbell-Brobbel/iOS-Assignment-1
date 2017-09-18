//
//  WeatherManager.swift
//  iOSAssignment1
//
//  Created by Campbell Brobbel on 15/8/17.
//  Copyright © 2017 CampbellRhys. All rights reserved.
//

import Foundation

// A class used to deal with the downloading and managing of all forecasts for a set of given locations.

class WeatherManager {
    
    private let weatherAPIUrlString = "https://api.openweathermap.org/data/2.5/forecast?"
    private let appID = "20b7b621ea367841bb406e0d35b236db"
    public static var shared : WeatherManager = WeatherManager()
    private var lastUpdated : Date?
    
    public private(set) var cities : [Location] = [Location.init(city: "Melbourne", country: "AU"), Location.init(city: "Sydney", country: "AU"), Location.init(city: "Brisbane", country: "AU")]
    
    var cityWeatherForecasts : [CityWeatherForecastManager] = []
    
    init() {
        updateAllCities(){
        }
    }
    
    // Download the forecasts for all the cities.
    public func updateAllCities(completion : () -> Void) {
        
        for city in cities {
            
            let urlString = "\(weatherAPIUrlString)q=\(city.city!),\(city.country!)&units=metric&appid=\(self.appID)"
            let url = URL(string: urlString)
            let sem = DispatchSemaphore(value: 0)
            let task = URLSession.shared.dataTask(with: url!) {data, response, error in
                
                if error != nil {
                    
                }
                else {
                    
                    do {
                        let cityWeatherDictionary = try JSONSerialization.jsonObject(with: data!, options: []) as! NSDictionary
                        
                        let cityWeatherManager = CityWeatherForecastManager(cityWeatherForecastDictionary: cityWeatherDictionary)
                        
                        self.cityWeatherForecasts.append(cityWeatherManager)
                        sem.signal()
                        
                    }
                    catch let error {
                        print(error.localizedDescription)
                    }
                    
                }
                
            }
            task.resume()
            sem.wait()

        }
        
        completion()
    }
    
    // Download and insert forecasts for a new city.
    public func addCity(location : Location) {
        
    }
    
    // Returns all forecasts for a given location
    public func forecastsFor(location : Location) -> [DailyWeather]? {
        
        var cityMatch : Location?
        
        for city in self.cities {
            
            if city.city == location.city && city.country == location.country {
                cityMatch = city
                break
            }
        }
        
        if cityMatch != nil {
            
            for cityWeather in self.cityWeatherForecasts {
                if cityWeather.location.city == cityMatch?.city {
                    
                    return cityWeather.dailyForecasts
                }
            }
        }
        return nil
    }
    
    // Returns a specific forecast for a location at a given time
    public func forecastFor(location : Location, closestTo time : Date) -> WeatherForecast? {
        let forecasts = forecastsFor(location: location)
        guard forecasts != nil else { return nil }
        
        var minutesBetweenDates : Int = -1
        var closestForecast : WeatherForecast?
        
        for dailyForecast in forecasts! {
            if Calendar.current.isDate(dailyForecast.date, inSameDayAs: time) {
                
                for forecast in dailyForecast.forecasts {
                    if  minutesBetweenDates < 0 {
                        closestForecast = forecast
                        minutesBetweenDates = minutesBetween(date1: time, date2: forecast.dateTime)
                    }
                    else {
                        let minuteDiff = minutesBetween(date1: time, date2: forecast.dateTime)
                        if minuteDiff < minutesBetweenDates {
                            closestForecast = forecast
                            minutesBetweenDates = minutesBetween(date1: time, date2: forecast.dateTime)

                        }

                    }
                }
                
                return closestForecast
            }
        }
        
        return nil
    }
    
    public func minutesBetween(date1: Date, date2 : Date) -> Int {
        return abs(Calendar.current.dateComponents([.minute], from: date1, to: date2).minute!)
    }
    
    
    // Determines if the weather data for a given location already exists 
    public func weatherDataIsKnownFor(location : Location) -> Bool {
        return false
    }
    
    public func datesWeatherIsKnownFor() -> [Date] {
        
        var dates : [Date] = []
        
        let cwm = self.cityWeatherForecasts[0]
        
        for forecast in cwm.dailyForecasts {
            dates.append(forecast.date)
        }
        
        return dates
    }
}

public struct Location {
    var city : String!
    var country : String!
}
//
//  WeatherManager.swift
//  iOSAssignment1
//
//  Created by Campbell Brobbel on 15/8/17.
//  Copyright © 2017 CampbellRhys. All rights reserved.
//

import Foundation

/// A class used to deal with the downloading and managing of all forecasts for a set of given locations.
class WeatherManager {
    
    /// Prefix String for the weather API address.
    private let weatherAPIUrlString = "https://api.openweathermap.org/data/2.5/forecast?"
    /// API Key needed for downloading weather data.
    private let appID = "20b7b621ea367841bb406e0d35b236db"
    /// A singleton object used for accessing all weather forecasts from every view controller.
    public static var shared : WeatherManager = WeatherManager()
    /// Major Cities In Australia
    public private(set) var cities : [Location] = [Location.init(name: "", address: "", city: "Melbourne", country: "AU"), Location.init(name: "",  address: "", city: "Sydney", country: "AU"), Location.init(name: "",  address: "", city: "Adelaide", country: "AU"), Location.init(name: "", address: "", city: "Perth", country: "AU"), Location.init(name: "",  address: "", city: "Hobart", country: "AU"), Location.init(name: "",  address: "", city: "Brisbane", country: "AU")]
    /// An array of cities created by the user.
    public private(set) var userCities : [Location] = []
    
    var cityWeatherForecasts : [CityWeatherForecastManager] = []
    
    init() {
       
    }
    
    /// Adds a single user location and downloads the weather forecasts associated with that location.
    public func addUserLocation(location: Location, completion: () -> Void) {
        
        for majorCity in self.cities {
            if location.city == majorCity.city && location.country == majorCity.country {
                completion()
                return
            }
        }
        
        for userLocation in self.userCities {
            if location.city == userLocation.city && location.country == userLocation.country {
                // Match is found. No need to download extra weather data.
                completion()
                return
            }
        }
        self.userCities.append(location)
        let cityUrl = location.city.replacingOccurrences(of: " ", with: "+")
        let urlString = "\(weatherAPIUrlString)q=\(cityUrl),\(location.country!)&units=metric&appid=\(self.appID)"
        let url = URL(string: urlString)
        let sem = DispatchSemaphore(value: 0)
        let task = URLSession.shared.dataTask(with: url!) {data, response, error in
            
            if error != nil {
                
            }
            else {
                
                do {
                    let cityWeatherDictionary = try JSONSerialization.jsonObject(with: data!, options: []) as! NSDictionary
                    
                    let cityWeatherManager = CityWeatherForecastManager(cityName: location.city, cityWeatherForecastDictionary: cityWeatherDictionary)
                    
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
        completion()
    }
    
    // Downloads the weather info for all of the cities.
    public func updateAllCities(completion : () -> Void) {
        
        for city in cities {
            print("\(city.city)")

            let urlString = "\(weatherAPIUrlString)q=\(city.city!),\(city.country!)&units=metric&appid=\(self.appID)"
            let url = URL(string: urlString)
            let sem = DispatchSemaphore(value: 0)
            let task = URLSession.shared.dataTask(with: url!) {data, response, error in
                
                if error != nil {
                    
                }
                else {
                    
                    do {
                        let cityWeatherDictionary = try JSONSerialization.jsonObject(with: data!, options: []) as! NSDictionary
                        
                        let cityWeatherManager = CityWeatherForecastManager(cityName: city.city, cityWeatherForecastDictionary: cityWeatherDictionary)
                        
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
        
        for city in self.userCities {
            print("\(city.city)")
            let urlString = "\(weatherAPIUrlString)q=\(city.city!.replacingOccurrences(of: " ", with: "+")),\(city.country!)&units=metric&appid=\(self.appID)"
            print(urlString)
            let url = URL(string: urlString)
            let sem = DispatchSemaphore(value: 0)
            let task = URLSession.shared.dataTask(with: url!) {data, response, error in
                
                if error != nil {
                    
                }
                else {
                    
                    do {
                        let cityWeatherDictionary = try JSONSerialization.jsonObject(with: data!, options: []) as! NSDictionary
                        
                        let cityWeatherManager = CityWeatherForecastManager(cityName: city.city, cityWeatherForecastDictionary: cityWeatherDictionary)
                        
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
    
    /// Returns all forecasts for a given location
    public func forecastsFor(location : Location) -> [DailyWeather]? {
        
        var cityMatch : Location?
        
        for city in self.cities {
            
            if city.city == location.city && city.country == location.country {
                cityMatch = city
                break
            }
        }
        
        for city in self.userCities {
            if city.city == location.city && city.country == location.country {
                print("USer City Match")
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
    
    /// Get the forecast for a location at a specific time if there exist forecasts for the day of the date.
    public func forecastFor(location : Location, closestTo time : Date) -> WeatherForecast? {
        print("Forecast For Location: \(location.city)")
        let forecasts = forecastsFor(location: location)
        guard forecasts != nil else { print("Returning Null")
            return nil }
        
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
    
    /// Calculates minutes between 2 dates.
    public func minutesBetween(date1: Date, date2 : Date) -> Int {
        return abs(Calendar.current.dateComponents([.minute], from: date1, to: date2).minute!)
    }
    
    
    /// Determines if the weather data for a given location already exists
    public func weatherDataIsKnownFor(location : Location) -> Bool {
        return false
    }
    
    /// Returns an array of dates the the weather manager knows about.
    public func datesWeatherIsKnownFor() -> [Date] {
        
        var dates : [Date] = []
        
        let cwm = self.cityWeatherForecasts[0]
        
        for forecast in cwm.dailyForecasts {
            dates.append(forecast.date)
        }
        
        return dates
    }
}

/// Structure used for holding information about a location.
public struct Location {
    var name: String!
    var address: String!
    var city : String!
    var country : String!
}

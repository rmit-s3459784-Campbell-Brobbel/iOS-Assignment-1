//
//  WeatherTests.swift
//  iOSAssignment1
//
//  Created by Campbell Brobbel on 8/10/17.
//  Copyright © 2017 CampbellRhys. All rights reserved.
//

import XCTest

class WeatherTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        let exp = expectation(description: "Weather Download")
        WeatherManager.shared.updateAllCities {
            exp.fulfill()
        }
        waitForExpectations(timeout: 30, handler: nil)
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testDailyWeatherLocations() {
        print("Testing Daily Weather Locations")
        print("City Forecasts Count: \(WeatherManager.shared.cityWeatherForecasts.count)")
        let cityForecasts = WeatherManager.shared.cityWeatherForecasts
        for cityForecast in cityForecasts {
            for dailyForecast in cityForecast.dailyForecasts {
                XCTAssert(dailyForecast.city == cityForecast.location.city, "Daily forecast and city forecast don't share the same location.")
            }
        }
    }
    
    func testDailyWeatherForecastTimes() {
        print("Testing Daily Weather Dates")
        let cityForecasts = WeatherManager.shared.cityWeatherForecasts
        
        for cityForecast in cityForecasts {
            for dailyForecast in cityForecast.dailyForecasts {
                for forecast in dailyForecast.forecasts {
                     XCTAssert(Calendar.current.isDate(forecast.dateTime, inSameDayAs: dailyForecast.date), "Forecast is not in the same date as its Daily Forecast object.")
                }
            }
        }
    }
    
    func testForecastsForLocation() {
        print("Testing Forecasts For Location")
        let location = Location(name: "", address: "", city: "Melbourne", country: "AU")
        let forecasts : [DailyWeather] = WeatherManager.shared.forecastsFor(location: location) ?? []
        print("\tForecasts For Location Forecast Count: \(forecasts.count)")
        for forecast in forecasts {
            XCTAssert(forecast.city == location.city, "Forecast For Location: City Doesn't Match.")
            XCTAssert(forecast.country == location.country, "Forecast For Location: Country Doesn't Match.")
        }
    }
    
    
    
}

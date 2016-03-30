//
//  City.swift
//  WeathR
//
//  Created by Shivam Kapur on 01/03/16.
//  Copyright © 2016 Shivam Kapur. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import MapKit
import CoreLocation

class City {
    private var _cityName:String!//Done
    private var _latitude:CLLocationDegrees!//Done
    private var _longitude:CLLocationDegrees!//Done
    private var _countryCode:String!//Done
    private var _weatherDescription:String!//Done
    private var _temperature:Double!//Done
    private var _temperatureMin:Double!//Done
    private var _temperatureMax:Double!//Done
    private var _humidity:Double!//Done
    private var _windSpeed:Double!//Done
    private var _windDirection:Double!//Done
    
    var cityName:String {
        return _cityName
    }
    
    var countryCode:String {
        return _countryCode
    }
    
    var weatherDescription:String {
        return _weatherDescription
    }
    
    var temperature:Double {
        return _temperature
    }
    
    var temperatureMin:Double {
        return _temperatureMin
    }
    
    var temperatureMax:Double {
        return _temperatureMax
    }
    
    var humidity:Double {
        return _humidity
    }
    
    var windSpeed:Double {
        return _windSpeed
    }
    
    var windDirection:Double {
        return _windDirection
    }
    
    var latitude:CLLocationDegrees {
        return _latitude
    }
    
    var longitude:CLLocationDegrees {
        return _longitude
    }
    
    init() {
        
    }
    
    convenience init(lat:CLLocationDegrees,lon:CLLocationDegrees) {
        self.init()
        self._latitude = lat
        self._longitude = lon
    }
   
    func downloadWeatherInfo(completed:downloadWeatherDetails) {
        
        let url = "\(BASE_URL)\(LATITUDE)\(self._latitude)\(LONGITUDE)\(self._longitude)\(API_KEY)\(UNITS)"
        
        let nsurl = NSURL(string: url)!
        
        Alamofire.request(.GET, nsurl).responseJSON { (response) -> Void in
            if let response = response.result.value as? Dictionary<String,AnyObject> {
                print(response)
                if let name = response["name"] as? String {
                    self._cityName = name
                }
                
                if let sys = response["sys"] as? Dictionary<String,AnyObject> {
                    if let country = sys["country"] as? String {
                        self._countryCode = country
                    }
                }
                
                if let main = response["main"] as? Dictionary<String,AnyObject> {
                    if let temp = main["temp"] as? Double {
                        self._temperature = temp
                    }
                    
                    if let temp_min = main["temp_min"] as? Double {
                        self._temperatureMin = temp_min
                    }
                    
                    if let temp_max = main["temp_max"] as? Double {
                        self._temperatureMax = temp_max
                    }
                    
                    if let humidity = main["humidity"] as? Double {
                        self._humidity = humidity
                    }
                }
                
                if let wind = response["wind"] as? Dictionary<String,AnyObject> {
                    if let speed = wind["speed"] as? Double {
                        self._windSpeed = speed
                    }
                    
                    if let deg = wind["deg"] as? Double {
                        self._windDirection = deg
                    }
                }
                
                if let weather = response["weather"] as? [Dictionary<String,AnyObject>] {
                    if let description = weather[0] as? Dictionary<String,AnyObject> {
                        if let desc = description["description"] as? String {
                            self._weatherDescription = desc
                        }
                    }
                }
            }
            completed()
        }
    }
}
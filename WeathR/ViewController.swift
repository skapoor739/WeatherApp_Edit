//
//  ViewController.swift
//  WeathR
//
//  Created by Shivam Kapur on 01/03/16.
//  Copyright © 2016 Shivam Kapur. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController,CLLocationManagerDelegate {

    @IBOutlet var cityAndCountryLabel: UILabel!
    @IBOutlet var humidityLabel: UILabel!
    @IBOutlet var weatherDescLabel: UILabel!
    @IBOutlet var temperatureLabel: UILabel!
    @IBOutlet var minMaxTemperatureLabel: UILabel!
    @IBOutlet var windSpeedLabel: UILabel!
    @IBOutlet var windDirectionLabel: UILabel!
    
    var city:City!
    
    let locationManager:CLLocationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        
        
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager.stopUpdatingLocation()
        let location = locations[0]
        city = City(lat: location.coordinate.latitude, lon: location.coordinate.longitude)
        
        city.downloadWeatherInfo { () -> () in
            self.updateUI()
        }
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
            print(error.debugDescription)
    }
    
    func updateUI() {
        cityAndCountryLabel.text = "\(city.cityName), \(city.countryCode)"
        weatherDescLabel.text = city.weatherDescription
        temperatureLabel.text = "\(city.temperature)"
        minMaxTemperatureLabel.text = "\(city.temperatureMin)    \(city.temperatureMax)"
        windSpeedLabel.text = "\(city.windSpeed)"
        windDirectionLabel.text = "\(city.windDirection)"
    }
}


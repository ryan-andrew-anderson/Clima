//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!

    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextField.delegate = self
        weatherManager.delegate = self
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
     
    @IBAction func locationPressed(_ sender: UIButton) {
        // triggers the locationManager Delegate didUpdateWeater() and requests location and up dates view
        locationManager.requestLocation()
    }
}

//MARK: - UITextFieldDelegate

extension WeatherViewController: UITextFieldDelegate {
    
    @IBAction func searchpressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
        print(searchTextField.text! )
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        print(searchTextField.text!)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        // Use searchTextField.text to get the weather for that city.
        if let city = searchTextField.text {
            print("Debug : \(city)")
            let cityStringWithNoSpaces = String(city.replacingOccurrences(of: " ", with: "+"))
            print(cityStringWithNoSpaces)
            weatherManager.fetchWeather(cityName: cityStringWithNoSpaces)
        }
        searchTextField.text = ""
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "type something"
            return false
        }
    }
}

//MARK: - WeatherManagerDelegate

extension WeatherViewController: WeatherManagerDelegate {
    
     func didUpdateWeater(_ weatherManager: WeatherManager, weather: WeatherModel) {
         // Updates view when the block of code finishes receiving data from the API
         DispatchQueue.main.async {
             self.temperatureLabel.text = weather.temperatureString
             self.conditionImageView.image = UIImage(systemName: weather.conditionName)
             self.cityLabel.text = weather.cityName
         }
     }
    
    func didFailWithError(error: Error) {
        print(error)
    }

}

//MARK: - CLLocationManagerDelegate

extension WeatherViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("got locaiton data")
        
       if let location = locations.last {
           locationManager.stopUpdatingLocation()
           let lat = location.coordinate.latitude
           let lon = location.coordinate.longitude
           weatherManager.fetchWeather(latitude: lat, longitude: lon)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

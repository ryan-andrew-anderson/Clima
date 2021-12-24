//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController, UITextFieldDelegate, WeatherManagerDelegate {
    
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    var weatherManager = WeatherManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherManager.delegate = self
        searchTextField.delegate = self
    }
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
        //        Use searchTextField.text to get the weather for that city.
        
        if let city = searchTextField.text {
            print("Debug : \(city)")
            let cityStringWithNoSpaces = String(city.replacingOccurrences(of: " ", with: ""))
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
    func didUpdateWeater(_ weatherManager: WeatherManager, weather: WeatherModel) {
        temperatureLabel.text = weather.temperatureString
        conditionImageView.image = UIImage(systemName: weather.conditionName)
        cityLabel.text = weather.cityName
    }

    func didFailWithError(error: Error) {
        print(error)
    }
    
}

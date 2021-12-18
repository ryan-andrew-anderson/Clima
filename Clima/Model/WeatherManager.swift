//
//  WeatherManager.swift
//  Clima
//
//  Created by Ryan Anderson on 12/18/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation

struct WeatherManager {
    let weatherURL = "http://api.openweathermap.org/data/2.5/weather?appid=6dbc259a546e8488c9d786703b615931&units=imperial"
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        print(urlString)
    }
    
    

}

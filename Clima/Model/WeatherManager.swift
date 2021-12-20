//
//  WeatherManager.swift
//  Clima
//
//  Created by Ryan Anderson on 12/18/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=6dbc259a546e8488c9d786703b615931&units=imperial"
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(urlString: urlString)
        print(urlString)
    }
    
    func performRequest(urlString: String) {
        //1.Create URL
        if let url = URL(string: urlString) {
            //2.Create a URLSession
            let session = URLSession(configuration: .default)
            //3.Give the session a task
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    print(error!)
                    return
                }
                if let safeData = data {
                    self.parseJSON(weather: safeData)
                }
            }
            //4.Start the Task
            task.resume()
        }
    }
    /// Turns JSON data with REST API  into a swift object
    func parseJSON(weather: Data) {
        // Declare JSON decoder
        let decoder = JSONDecoder()
        // use do block to "catch" any error's
        do {
            //creating data object
            let decodedData = try decoder.decode(WeatherData.self, from: weather)
            //printing data object
            print(decodedData.weather.description)
        }catch {
            //if error pops up, it prints
            print(error)
        }
    }
}

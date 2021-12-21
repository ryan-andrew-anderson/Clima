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
                    self.parseJSON(weatherData: safeData)
                }
            }
            //4.Start the Task
            task.resume()
        }
    }
    /// Turns JSON data with REST API  into a swift object
    func parseJSON(weatherData: Data) {
        // Declare JSON decoder
        let decoder = JSONDecoder()
        // use do block to "catch" any error's. Basically, do this and if erros come, ill stop the process and catch errors so you can print them
        do {
            //Convertiong JSON-Data into Swift-Data using the outline from WetherData
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            //creating readable "id" data from decoder
            let id = decodedData.weather[0].id
            //creating readable "temp" data from decoder
            let temp = decodedData.main.temp
            //creating readable "name" data from decoder
            let name = decodedData.name
            // now that data is decoded, create a Swift Object called WeatherModel
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
            
            print(weather.conditionName)
            print(weather.temperatureString)
        }catch {
            //if error pops up, it prints
            print(error)
        }
    }
}

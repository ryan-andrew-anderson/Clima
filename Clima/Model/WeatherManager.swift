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
            let id = decodedData.weather[0].id
            getConditionName(weatherId: id)
        }catch {
            //if error pops up, it prints
            print(error)
        }
    }
    func getConditionName(weatherId: Int) -> String {
        switch weatherId {
        case 200...232:
            print("Thunderstorm \(weatherId)")
            return "cloud.bolt"
        case 300...332:
            print("Drizzle \(weatherId)")
            return "cloud.drizzle"
        case 500...532:
            print("Rain \(weatherId)")
            return "cloud.rain"
        case 600...632:
            print("Snow \(weatherId)")
            return "cloud.snow"
        case 701...781:
            print("Mist \(weatherId)")
            return "cloud.fog"
        case 800:
            print("Clear \(weatherId)")
            return "sun.max"
        case 801...804:
            print("Clouds \(weatherId)")
            return "cloud.bolt"
        default:
            print("Error\(weatherId)")
            return "cloud"
        }
    }
}

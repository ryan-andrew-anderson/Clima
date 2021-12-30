//
//  WeatherManager.swift
//  Clima
//
//  Created by Ryan Anderson on 12/18/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeater(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=6dbc259a546e8488c9d786703b615931&units=imperial"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(with: urlString)
        print(urlString)
    }
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        performRequest(with: urlString)
        print(urlString)
    }
    
    ///Creates the URL, Session, and SessionTask in order to recieve data from the API
    func performRequest(with urlString: String) {
        //1.Create URL
        if let url = URL(string: urlString) {
            //2.Create a URLSession
            let session = URLSession(configuration: .default)
            //3.Give the session a task
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    //Unwraps newly parsed data
                    if let weather = self.parseJSON(safeData) {
                            //passes the new swift object over to the WeatherViewController to be used
                            delegate?.didUpdateWeater(self, weather: weather)
                        print(weather)
                    }
                }
            }
            //4.Start the Task
            task.resume()
        }
    }
    
    /// Turns JSON data with REST API  into a swift object
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
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
            return weather
          
        }catch {
            //if error pops up, it prints
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}

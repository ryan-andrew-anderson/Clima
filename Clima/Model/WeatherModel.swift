//
//  WeatherModel.swift
//  Clima
//
//  Created by Ryan Anderson on 12/20/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation

struct WeatherModel {
    let conditionId: Int
    let cityName: String
    let temperature: Double
    
    var temperatureString: String {
        return "\(String(format: "%.1f", temperature))F"
    }
    
    var conditionName: String {
        switch conditionId {
        case 200...232:
            print("Thunderstorm \(conditionId)")
            return "cloud.bolt"
        case 300...332:
            print("Drizzle \(conditionId)")
            return "cloud.drizzle"
        case 500...532:
            print("Rain \(conditionId)")
            return "cloud.rain"
        case 600...632:
            print("Snow \(conditionId)")
            return "cloud.snow"
        case 701...781:
            print("Mist \(conditionId)")
            return "cloud.fog"
        case 800:
            print("Clear \(conditionId)")
            return "sun.max"
        case 801...804:
            print("Clouds \(conditionId)")
            return "cloud"
        default:
            print("Error\(conditionId)")
            return "cloud"
        }
        //        return
    }
}

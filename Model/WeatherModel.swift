//
//  WeatherModel.swift
//  Clima
//
//  Created by Marwan Khalawi on 2/24/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

struct WeatherModel {
    let conditionId: Int
    let cityName: String
    let temp: Double
    
    //This way of creating a property is called a computed property
    var tempString: String {
        return String(format: "%.1f", temp)
    }
    
    var conditionName: String {
       switch conditionId {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
    }
}

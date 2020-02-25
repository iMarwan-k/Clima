//
//  WeatherData.swift
//  Clima
//
//  Created by Marwan Khalawi on 2/24/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

struct WeatherData : Codable {
    let weather: [Weather]
    let main: Main
    let name: String
}

struct Weather : Codable {
    let id : Int
    let description: String
}

struct Main : Codable {
    let temp: Double
    let feels_like: Double
    let temp_min: Double
    let temp_max: Double
}

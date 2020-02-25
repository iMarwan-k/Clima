//
//  WeatherManager.swift
//  Clima
//
//  Created by Marwan Khalawi on 2/24/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, _ weather: WeatherModel)
    func didFailWithError(error: Error)
}


struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=07420b29663005cbe16c622d110cfe1c&units=metric&"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather (cityName: String){
        let urlString = "\(weatherURL)q=\(cityName)"
        performRequest(with: urlString)
    }
    
    func fetchWeather (lat: Double, lon: Double) {
        let urlString = "\(weatherURL)lat=\(lat)&lon=\(lon)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String){
        //create url
        if let url = URL(string: urlString) {
            //create urlSession
            let session = URLSession(configuration: .default)
            
            //give the session a task
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safaData = data {
                    if let weather = self.parseJSON(safaData) {
                        self.delegate?.didUpdateWeather(self,weather)
                    }
                }
            }
            //start the task
            task.resume()
        }
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let name = decodedData.name
            let temp = decodedData.main.temp
            let weather = WeatherModel(conditionId: id, cityName: name, temp: temp)
            return weather
        } catch  {
            delegate?.didFailWithError(error: error)
           return nil
        }
    }
    
}

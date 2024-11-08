//
//  WeatherService.swift
//  WeatherWonders
//
//  Created by Seher Ayesha on 01/11/2024.
//

import Foundation

class WeatherService {
    
    let apiKey = "YOUR_API_KEY" // Replace with your actual API key
    let baseURL = "https://api.weatherapi.com/v1/current.json"

    func fetchWeather(for city: String, completion: @escaping (WeatherResponse?) -> Void) {
        guard let url = URL(string: "\(baseURL)?key=\(apiKey)&q=\(city)") else {
            completion(nil)
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }

            let weatherResponse = try? JSONDecoder().decode(WeatherResponse.self, from: data)
            completion(weatherResponse)
        }
        task.resume()
    }
}

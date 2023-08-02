//
//  NetworkLayer.swift
//  iOS Project 2
//
//  Created by Mac on 2023-08-02.
//

import Foundation

class NetworkLayer {
    
    private init () { }
    
    static let singleton = NetworkLayer()
    
    func getCityWeatherFor(cityName: String, completion: @escaping (WeatherModel?, Error?) -> ()) {
        let url = "https://api.weatherapi.com/v1/current.json?key=481c87a2c9c54e2e992210038230208&q=\(cityName)&aqi=no".addingPercentEncoding(withAllowedCharacters:
                .urlFragmentAllowed)!
        guard let finalUrl = URL(string: url) else { return }
        let task = URLSession.shared.dataTask(with: finalUrl, completionHandler: { data, response, error in
            guard let jsonData = data else { return }
            do {
                let weatherResponse = try JSONDecoder().decode(WeatherModel.self, from: jsonData)
                completion(weatherResponse, nil)
            } catch let parseErr {
                print("JSON Parsing Error", parseErr)
                completion(nil, parseErr)
            }
        })
        task.resume()
        
    }
}

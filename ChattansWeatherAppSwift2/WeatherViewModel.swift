//
//  WeatherViewModel.swift
//  ChattansWeatherAppSwift2
//
//  Created by Emy Alwin on 2024-04-01.
//

//import Foundation
import SwiftUI

struct WeatherData: Decodable {
    let weather: [WeatherInfo]
    let main: MainInfo
    let name: String

    struct WeatherInfo: Decodable {
        let description: String
        let icon: String
    }

    struct MainInfo: Decodable {
        let temp: Double
        let tempMin: Double
        let tempMax: Double

        private enum CodingKeys: String, CodingKey {
            case temp, tempMin = "temp_min", tempMax = "temp_max"
        }
    }

    var weatherIconInfo: (imageName: String, color: Color) {
        switch weather.first?.icon {
        case "01d":
            return ("sun.max.fill", .yellow)
        case "01n":
            return ("moon.zzz.fill", .gray)
        case "02d":
            return ("cloud.sun.fill", .white)
        case "02n":
            return ("cloud.moon.fill", .white)
        case "03d", "03n", "04d", "04n":
            // bundled together but skipped "smoke.fill"
            return ("cloud.fill", .white)
        case "09d", "09n", "10d", "10n":     
            //bundled together but skipped "cloud.sun/moon.rain.fill"
            return ("cloud.rain.fill", .white)
        case "11d", "11n":
            return ("cloud.bolt.fill", .white)
        case "13d", "13n":
            return ("cloud.snow.fill", .white)
        case "50d", "50n":
            return ("wind", .white)
        default:
            return ("sparkles", .yellow) // AUTHOR MODIFIED SO IT'S YELLOW
        }
    }
}


class WeatherViewModel: ObservableObject {
    @Published var weatherData: WeatherData?
    let apiKey = "53b6222b974d4277240d894c4b77f998" // Replace with your API key
    
    func fetchWeatherData(latitude: String, longitude: String) {
        guard let lat = Double(latitude), let lon = Double(longitude) else {
            print("Invalid latitude or longitude")
            return
        }
        
        let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=\(apiKey)&units=metric"
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            if let decodedData = try? JSONDecoder().decode(WeatherData.self, from: data) {
                DispatchQueue.main.async {
                    self.weatherData = decodedData
                }
            } else {
                print("Failed to decode JSON.")
            }
        }.resume()
    }
}

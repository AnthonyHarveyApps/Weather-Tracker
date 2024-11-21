//
//  WeatherServiceProtocol.swift
//  Weather Tracker
//
//  Created by Anthony Harvey on 11/20/24.
//

import Foundation

protocol WeatherServiceProtocol {
    func fetchWeather(by id: String) async throws -> WeatherData
    func searchCity(query: String) async throws -> [LocationForSearchResult]
}

class WeatherService: WeatherServiceProtocol {
    private let apiKey: String
    private let baseURL = "https://api.weatherapi.com/v1"
    
#error("ENTER API KEY HERE")
    init(apiKey: String = "ENTER API KEY HERE") {
        self.apiKey = apiKey
    }
    
    func fetchWeather(by id: String) async throws -> WeatherData {
        guard let url = URL(string: "\(baseURL)/current.json?key=\(apiKey)&q=id:\(id)") else {
            throw NetworkError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.invalidResponse
        }
        return try JSONDecoder().decode(WeatherData.self, from: data)
    }
    
    func searchCity(query: String) async throws -> [LocationForSearchResult] {
        guard let url = URL(string: "\(baseURL)/search.json?key=\(apiKey)&q=\(query)") else {
            throw NetworkError.invalidURL
        }
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.invalidResponse
        }
        return try JSONDecoder().decode([LocationForSearchResult].self, from: data)
    }
}

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
}

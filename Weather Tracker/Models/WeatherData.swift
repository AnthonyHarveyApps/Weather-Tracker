//
//  WeatherData.swift
//  Weather Tracker
//
//  Created by Anthony Harvey on 11/20/24.
//

import Foundation

struct WeatherData: Codable {
    let location: Location
    let current: Current
    
    enum CodingKeys: String, CodingKey {
        case location
        case current
    }
    
    static let exampleWeatherData = WeatherData(
        location: Location(
            name: "Nashua",
            region: "New Hampshire",
            country: "United States of America",
            latitude: 42.7653,
            longitude: -71.4681,
            timeZoneId: "America/New_York",
            localTimeEpoch: 1732112813,
            localTime: "2024-11-20 09:26"
        ),
        current: Current(
            lastUpdatedEpoch: 1732112100,
            lastUpdated: "2024-11-20 09:15",
            temperatureCelsius: 5.3,
            temperatureFahrenheit: 41.5,
            isDay: 1,
            condition: Condition(
                description: "Sunny",
                iconUrl: "//cdn.weatherapi.com/weather/64x64/day/113.png",
                code: 1000
            ),
            windSpeedMph: 3.6,
            windSpeedKph: 5.8,
            windDegree: 348,
            windDirection: "NNW",
            pressureMb: 1011.0,
            pressureIn: 29.86,
            precipitationMm: 0.0,
            precipitationIn: 0.0,
            humidity: 76,
            cloud: 0,
            feelsLikeCelsius: 4.2,
            feelsLikeFahrenheit: 39.5,
            windChillCelsius: 2.0,
            windChillFahrenheit: 35.6,
            heatIndexCelsius: 4.4,
            heatIndexFahrenheit: 39.8,
            dewPointCelsius: 2.4,
            dewPointFahrenheit: 36.4,
            visibilityKm: 16.0,
            visibilityMiles: 9.0,
            uvIndex: 0.7,
            gustSpeedMph: 5.8,
            gustSpeedKph: 9.3
        )
    )
    
}

struct Location: Codable {
    let name: String
    let region: String
    let country: String
    let latitude: Double
    let longitude: Double
    let timeZoneId: String
    let localTimeEpoch: Int
    let localTime: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case region
        case country
        case latitude = "lat"
        case longitude = "lon"
        case timeZoneId = "tz_id"
        case localTimeEpoch = "localtime_epoch"
        case localTime = "localtime"
    }
}

struct Current: Codable {
    let lastUpdatedEpoch: Int
    let lastUpdated: String
    let temperatureCelsius: Double
    let temperatureFahrenheit: Double
    let isDay: Int
    let condition: Condition
    let windSpeedMph: Double
    let windSpeedKph: Double
    let windDegree: Int
    let windDirection: String
    let pressureMb: Double
    let pressureIn: Double
    let precipitationMm: Double
    let precipitationIn: Double
    let humidity: Int
    let cloud: Int
    let feelsLikeCelsius: Double
    let feelsLikeFahrenheit: Double
    let windChillCelsius: Double
    let windChillFahrenheit: Double
    let heatIndexCelsius: Double
    let heatIndexFahrenheit: Double
    let dewPointCelsius: Double
    let dewPointFahrenheit: Double
    let visibilityKm: Double
    let visibilityMiles: Double
    let uvIndex: Double
    let gustSpeedMph: Double
    let gustSpeedKph: Double
    
    enum CodingKeys: String, CodingKey {
        case lastUpdatedEpoch = "last_updated_epoch"
        case lastUpdated = "last_updated"
        case temperatureCelsius = "temp_c"
        case temperatureFahrenheit = "temp_f"
        case isDay = "is_day"
        case condition
        case windSpeedMph = "wind_mph"
        case windSpeedKph = "wind_kph"
        case windDegree = "wind_degree"
        case windDirection = "wind_dir"
        case pressureMb = "pressure_mb"
        case pressureIn = "pressure_in"
        case precipitationMm = "precip_mm"
        case precipitationIn = "precip_in"
        case humidity
        case cloud
        case feelsLikeCelsius = "feelslike_c"
        case feelsLikeFahrenheit = "feelslike_f"
        case windChillCelsius = "windchill_c"
        case windChillFahrenheit = "windchill_f"
        case heatIndexCelsius = "heatindex_c"
        case heatIndexFahrenheit = "heatindex_f"
        case dewPointCelsius = "dewpoint_c"
        case dewPointFahrenheit = "dewpoint_f"
        case visibilityKm = "vis_km"
        case visibilityMiles = "vis_miles"
        case uvIndex = "uv"
        case gustSpeedMph = "gust_mph"
        case gustSpeedKph = "gust_kph"
    }
}

struct Condition: Codable {
    let description: String
    let iconUrl: String
    let code: Int
    
    enum CodingKeys: String, CodingKey {
        case description = "text"
        case iconUrl = "icon"
        case code
    }
}

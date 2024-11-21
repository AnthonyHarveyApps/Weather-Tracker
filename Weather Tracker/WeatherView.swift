//
//  WeatherView.swift
//  Weather Tracker
//
//  Created by Anthony Harvey on 11/20/24.
//

import SwiftUI


struct WeatherView: View {
    @AppStorage(fahrenheitInsteadOfCelsiusKey) var fahrenheitInsteadOfCelsius: Bool = false
    
    let weather: WeatherData
    
    enum Constants {
        static let iconBaseUrl = "https:"
        static let locationIcon = "location.fill"
        static let humidityTitle = "Humidity"
        static let uvTitle = "UV"
        static let feelsLikeTitle = "Feels like"
    }
    
    var body: some View {
        VStack(spacing: 12) {
            weatherIcon
            locationInfo
            temperature
            weatherDetails
        }
        .padding()
    }

    // MARK: - Extracted Views
    var weatherIcon: some View {
        AsyncImage(url: URL(string: Constants.iconBaseUrl + weather.current.condition.iconUrl)) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 164, height: 164)
        } placeholder: {
            ProgressView()
                .frame(width: 64, height: 64)
        }
    }
    
    var locationInfo: some View {
        HStack {
            Text(weather.location.name)
                .font(.system(size: 34, weight: .bold))
                .foregroundColor(.primary)
            Image(systemName: Constants.locationIcon)
        }
    }
    
    var temperature: some View {
        Text("\(fahrenheitInsteadOfCelsius ? Int(weather.current.temperatureFahrenheit) : Int(weather.current.temperatureCelsius))°")
            .font(.system(size: 80, weight: .bold))
            .foregroundColor(.primary)
    }
    
    var weatherDetails: some View {
        HStack(spacing: 30) {
            WeatherDetailRow(
                title: Constants.humidityTitle,
                value: "\(weather.current.humidity)%"
            )
            WeatherDetailRow(
                title: Constants.uvTitle,
                value: String(format: "%.1f", weather.current.uvIndex)
            )
            WeatherDetailRow(
                title: Constants.feelsLikeTitle,
                value: "\(fahrenheitInsteadOfCelsius ? Int(weather.current.feelsLikeFahrenheit) : Int(weather.current.feelsLikeCelsius))°"
            )
        }
        .padding(.horizontal)
        .padding(.vertical, 24)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.secondary.opacity(0.1))
        )
    }
}

#Preview {
    WeatherView(weather: WeatherData.exampleWeatherData)
}

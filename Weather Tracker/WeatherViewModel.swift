//
//  WeatherViewModel.swift
//  Weather Tracker
//
//  Created by Anthony Harvey on 11/20/24.
//

import Foundation

@MainActor
class WeatherViewModel: ObservableObject {
    @Published var currentWeather: WeatherData?
    @Published var searchResults: [LocationForSearchResult] = []
    @Published var isLoading = false
    @Published var searchResultsWithWeather: [Int : WeatherData] = [:]
    
    private let weatherService: WeatherServiceProtocol
    private let storageService: StorageServiceProtocol
    
    enum WeatherViewModelError: LocalizedError {
        case emptyQuery
        
        var errorDescription: String? {
            switch self {
            case .emptyQuery:
                return "The search query cannot be empty."
            }
        }
    }
    
    init(weatherService: WeatherServiceProtocol = WeatherService(),
         storageService: StorageServiceProtocol = StorageService()) {
        self.weatherService = weatherService
        self.storageService = storageService
        
        refetchLastCity()
    }
    
    func refetchLastCity() {
        if let lastCity = storageService.getLastCity() {
            Task {
                await fetchWeather(by: lastCity)
            }
        }
    }
    
    // MARK: - ALERT QUEUEING
    private var alertQueue: [AlertItem] = []
    @Published private(set) var currentAlert: AlertItem?
    @Published var showAlert = false
    
    private func enqueueAlert(title: String, message: String) {
        let alertItem = AlertItem(title: title, message: message)
        alertQueue.append(alertItem)
        showNextAlert()
    }
    
    private func showNextAlert() {
        guard !showAlert, let nextAlert = alertQueue.first else { return }
        currentAlert = nextAlert
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.showAlert = true
        }
    }
    
    func alertDismissed() {
        showAlert = false
        alertQueue.removeFirst()
        showNextAlert()
    }
    
    func fetchWeather(by id: String) async {
        isLoading = true
        
        do {
            currentWeather = try await weatherService.fetchWeather(by: id)
            storageService.saveCity(id)
            searchResults = []
        } catch {
            enqueueAlert(title: "Weather Fetch Error", message: error.localizedDescription)
        }
        
        isLoading = false
    }
    
    func getWeatherForSearchResults() {
        for searchResult in searchResults {
            Task { @MainActor in
                let weather = try? await weatherService.fetchWeather(by: "\(searchResult.id)")
                if let weather {
                    self.searchResultsWithWeather[searchResult.id] = weather
                }
            }
        }
    }
    
    func searchCities(query: String) async {
        guard !query.isEmpty else {
            if currentWeather == nil {
                enqueueAlert(title: "Search Error", message: WeatherViewModelError.emptyQuery.errorDescription ?? "Unknown error.")
            }
            searchResults = []
            return
        }
        
        do {
            searchResults = try await weatherService.searchCity(query: query)
            getWeatherForSearchResults()
        } catch {
            enqueueAlert(title: "Search Error", message: error.localizedDescription)
        }
    }
}

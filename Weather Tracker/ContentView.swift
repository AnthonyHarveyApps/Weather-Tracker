//
//  ContentView.swift
//  Weather Tracker
//
//  Created by Anthony Harvey on 11/20/24.
//

import SwiftUI
import Combine


struct ContentView: View {
    @AppStorage(fahrenheitInsteadOfCelsiusKey) var fahrenheitInsteadOfCelsius: Bool = false
    @StateObject private var viewModel = WeatherViewModel()
    @State private var searchText = ""
    @State private var isSearching = false
    @State private var cancellable: AnyCancellable?
    
    private let debouncer = Debouncer(delay: 0.6)
    
    enum Constants {
        static let noCitySelectedMessage = "No City Selected"
        static let searchPromptPrefix = "Please"
        static let searchPromptSuffixSearch = "Search For"
        static let searchPromptSuffixSelect = "Select"
        static let searchPromptSuffixCity = "A City"
    }
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottomTrailing) {
                VStack {
                    searchBar
                    if viewModel.searchResults.isEmpty {
                        weatherContent
                    }
                }
                .frame(maxHeight: .infinity, alignment: .top)
                .onChange(of: searchText, perform: handleSearchTextChange)
                
                toggleFahrenheitInsteadOfCelsius
            }
        }
        .onForeground {
            viewModel.refetchLastCity()
        }
        .alert(
            isPresented: $viewModel.showAlert) {
                Alert(
                    title: Text(viewModel.currentAlert?.title ?? ""),
                    message: Text(viewModel.currentAlert?.title ?? ""))
            }
        
    }
    
    // MARK: - Extracted Views
    private var toggleFahrenheitInsteadOfCelsius: some View {
        Toggle(isOn: $fahrenheitInsteadOfCelsius) {
            Text(fahrenheitInsteadOfCelsius ? "°F" : "°C")
                .font(.callout.bold())
        }
        .padding()
        .background(Color(.systemBackground).opacity(0.8))
        .clipShape(Capsule())
        .frame(width: 125)
        .frame(maxWidth: .infinity, alignment: .trailing)
        .padding()
    }
    
    private var searchBar: some View {
        SearchBar(
            text: $searchText,
            isSearching: $isSearching,
            results: $viewModel.searchResults,
            searchResultsWithWeather: $viewModel.searchResultsWithWeather
        ) { id in
            Task {
                await viewModel.fetchWeather(by: id)
                isSearching = false
                searchText = ""
            }
        }
    }
    
    private var weatherContent: some View {
        Group {
            if let weather = viewModel.currentWeather {
                WeatherView(weather: weather)
            } else {
                noCitySelectedMessage
            }
        }
    }
    
    private var noCitySelectedMessage: some View {
        VStack {
            Spacer()
            Text(Constants.noCitySelectedMessage)
                .font(.title.bold())
                .lineLimit(1)
                .minimumScaleFactor(0.3)
            Text("\(Constants.searchPromptPrefix) \(viewModel.searchResults.isEmpty ? Constants.searchPromptSuffixSearch : Constants.searchPromptSuffixSelect) \(Constants.searchPromptSuffixCity)")
                .font(.callout.bold())
                .lineLimit(1)
                .minimumScaleFactor(0.3)
            Spacer()
        }
    }
    
    // MARK: - Methods
    private func handleSearchTextChange(_ newValue: String) {
        debouncer.call {
            Task {
                await viewModel.searchCities(query: newValue)
            }
        }
    }
}

#Preview {
    ContentView()
}

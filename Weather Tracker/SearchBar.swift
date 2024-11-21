//
//  SearchBar.swift
//  Weather Tracker
//
//  Created by Anthony Harvey on 11/20/24.
//

import SwiftUI

struct SearchBar: View {
    @AppStorage(fahrenheitInsteadOfCelsiusKey) var fahrenheitInsteadOfCelsius: Bool = false
    
    @Binding var text: String
    @Binding var isSearching: Bool
    @Binding var results: [LocationForSearchResult]
    @Binding var searchResultsWithWeather: [Int : WeatherData]
    
    let onCitySelected: (String) -> Void
    
    enum Constants {
        static let searchPlaceholder = "Search Location"
        static let magnifyingGlassIcon = "magnifyingglass"
        static let clearIcon = "xmark.circle.fill"
    }
    
    var body: some View {
        ZStack {
            searchOverlay
            searchContent
        }
    }
    
    func selectTopResult() {
        if let topResult = self.results.first {
            onCitySelected("\(topResult.id)")
        }
    }
    
    // MARK: - Extracted Views
    private var searchOverlay: some View {
        Group {
            if isSearching {
                Color.black.opacity(0.3)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        isSearching = false
                    }
            }
        }
    }
    
    private var searchContent: some View {
        VStack(spacing: 0) {
            searchField
            searchResults
        }
    }
    
    private var searchField: some View {
        HStack {
            TextField(Constants.searchPlaceholder, text: $text)
                .textFieldStyle(PlainTextFieldStyle())
                .onSubmit {
                    selectTopResult()
                }
                .onTapGesture {
                    isSearching = true
                }
                .onChange(of: text) { newValue in
                    if newValue.isEmpty {
                        isSearching = false
                    }
                }
            
            if !text.isEmpty {
                clearButton
            }
            
            Image(systemName: Constants.magnifyingGlassIcon)
                .foregroundColor(.secondary)
                .opacity(0.7)
        }
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: 18)
                .fill(Color(.systemGray6))
        )
        .padding(.horizontal)
    }
    
    private var clearButton: some View {
        Button(action: {
            text = ""
        }) {
            Image(systemName: Constants.clearIcon)
                .foregroundColor(.secondary)
        }
    }
    
    private var searchResults: some View {
        Group {
            if !isSearching && !results.isEmpty {
                ScrollView {
                    VStack(spacing: 8) {
                        ForEach(
                            results.indices,
                            id: \.self
                        ) { index in
                            let location = results[index]
                            SearchResultRow(
                                location: location,
                                temperature: fahrenheitInsteadOfCelsius ? searchResultsWithWeather[location.id]?.current.temperatureFahrenheit : searchResultsWithWeather[location.id]?.current.temperatureCelsius,
                                imageURL: searchResultsWithWeather[location.id]?.current.condition.iconUrl
                            ) {
                                onCitySelected("\(results[index].id)")
                            }
                        }
                    }
                    .padding()
                }
            }
        }
    }
}

#Preview {
    SearchBar(
        text: .constant("San"),
        isSearching: .constant(true),
        results: .constant([
            LocationForSearchResult(
                id: 1,
                name: "San Diego",
                region: "California",
                country: "United States of America",
                lat: 32.72,
                lon: -117.16,
                url: "san-diego-california-united-states-of-america"
            ),
            LocationForSearchResult(
                id: 2,
                name: "San Francisco",
                region: "California",
                country: "United States of America",
                lat: 37.77,
                lon: -122.42,
                url: "san-francisco-california-united-states-of-america"
            )
        ]), searchResultsWithWeather: .constant([:]),
        onCitySelected: { _ in }
    )
}

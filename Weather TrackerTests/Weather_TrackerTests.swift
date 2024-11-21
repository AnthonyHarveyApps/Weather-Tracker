//
//  Weather_TrackerTests.swift
//  Weather TrackerTests
//
//  Created by Anthony Harvey on 11/20/24.
//

import XCTest
@testable import Weather_Tracker

@MainActor
final class Weather_TrackerTests: XCTestCase {
    var viewModel: WeatherViewModel!
      
    override func setUpWithError() throws {
        viewModel = WeatherViewModel()
    }
      
    override func tearDownWithError() throws {
        viewModel = nil
    }
      
    func testInitialWeatherState() throws {
        // Test initial state of the weather view model
        XCTAssertNil(viewModel.currentWeather, "Current weather should be nil when app starts")
        XCTAssertFalse(viewModel.isLoading, "Loading state should be false initially")
        XCTAssertNil(viewModel.currentAlert, "currentAlert should be nil initially")
    }

    func testEmptyCitySearch() async throws {
        // Test empty search query handling
        await viewModel.searchCities(query: "")
        XCTAssertTrue(viewModel.searchResults.isEmpty, "Search results should be empty for empty query")
    }
}

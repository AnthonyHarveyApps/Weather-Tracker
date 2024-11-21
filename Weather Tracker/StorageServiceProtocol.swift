//
//  StorageServiceProtocol.swift
//  Weather Tracker
//
//  Created by Anthony Harvey on 11/20/24.
//

import Foundation

protocol StorageServiceProtocol {
    func saveCity(_ city: String)
    func getLastCity() -> String?
}

class StorageService: StorageServiceProtocol {
    private let defaults = UserDefaults.standard
    private let lastCityKey = "lastSearchedCity"
    
    func saveCity(_ city: String) {
        defaults.set(city, forKey: lastCityKey)
    }
    
    func getLastCity() -> String? {
        return defaults.string(forKey: lastCityKey)
    }
}

//
//  Location.swift
//  Weather Tracker
//
//  Created by Anthony Harvey on 11/20/24.
//

import Foundation

struct LocationForSearchResult: Codable {
    let id: Int
    let name: String
    let region: String
    let country: String
    let lat: Double
    let lon: Double
    let url: String
    
    var uniqueIdentifier: String {
        return "\(name)_\(region)_\(country)"
    }
}

//
//  WeatherDetailRow.swift
//  Weather Tracker
//
//  Created by Anthony Harvey on 11/20/24.
//

import SwiftUI

struct WeatherDetailRow: View {
    let title: String
    let value: String
    
    var body: some View {
        VStack {
            Text(title)
                .foregroundColor(.secondary)
            Text(value)
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(.secondary)
        }
    }
}

#Preview {
    WeatherDetailRow(title: "Humidity", value: "46%")
}


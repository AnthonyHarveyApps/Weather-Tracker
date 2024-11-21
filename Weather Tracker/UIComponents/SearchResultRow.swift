//
//  SearchResultRow.swift
//  Weather Tracker
//
//  Created by Anthony Harvey on 11/20/24.
//

import SwiftUI

struct SearchResultRow: View {
    let location: LocationForSearchResult
    let temperature: Double?
    let imageURL: String?
    
    let onTap: () -> Void
    
    enum Constants {
        static let iconBaseUrl = "https:"
        static let nameFontSize: CGFloat = 16
        static let detailsFontSize: CGFloat = 14
        static let verticalSpacing: CGFloat = 4
        static let padding: CGFloat = 16
    }
    
    var body: some View {
        Button(action: onTap) {
            rowContent
                .padding(Constants.padding)
        }
        .background(RoundedRectangle(cornerRadius: 16).foregroundStyle(Color.primary.opacity(0.1)))
    }
    
    // MARK: - Extracted Views
    private var rowContent: some View {
        HStack {
            VStack(alignment: .leading) {
                locationDetails
                tempDetails
            }
            Spacer()
            weatherIcon
        }
    }
    
    private var tempDetails: some View {
        Group {
            if let temperature {
                Text("\(Int(temperature))°")
                    .font(.system(size: 40, weight: .bold))
                    .foregroundColor(.primary)
            }
            
        }
    }
    
    private var locationDetails: some View {
        VStack(alignment: .leading, spacing: Constants.verticalSpacing) {
            Text(location.name)
                .font(.system(size: Constants.nameFontSize, weight: .bold))
                .foregroundColor(.primary)
                .lineLimit(1)
                .minimumScaleFactor(0.7)
            Text("\(location.region), \(location.country)")
                .font(.system(size: Constants.detailsFontSize))
                .foregroundColor(.secondary)
                .lineLimit(1)
                .minimumScaleFactor(0.7)
        }
    }
        
    var weatherIcon: some View {
        Group {
            if let imageURL, let url = URL(string: Constants.iconBaseUrl + imageURL) {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 60, height: 60)
                } placeholder: {
                    ProgressView()
                        .frame(width: 60, height: 60)
                }
            } else {
                EmptyView()
            }
        }
    }
}

#Preview {
    SearchResultRow(
        location: LocationForSearchResult(
            id: 2,
            name: "San Francisco",
            region: "California",
            country: "United States of America",
            lat: 37.77,
            lon: -122.42,
            url: "san-francisco-california-united-states-of-america"
        ),
        temperature: 55,
        imageURL: nil,
        onTap: {
        })
}

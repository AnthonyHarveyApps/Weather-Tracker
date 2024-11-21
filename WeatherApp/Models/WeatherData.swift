struct WeatherData: Codable {
    let location: Location
    let current: Current
    
    struct Location: Codable {
        let name: String
        let region: String
        let country: String
    }
    
    struct Current: Codable {
        let tempC: Double
        let feelslikeC: Double
        let humidity: Int
        let uv: Double
        let condition: Condition
        
        struct Condition: Codable {
            let text: String
            let icon: String
        }
        
        enum CodingKeys: String, CodingKey {
            case tempC = "temp_c"
            case feelslikeC = "feelslike_c"
            case humidity
            case uv
            case condition
        }
    }
} 
import Foundation

struct AirportCity: Identifiable, Codable, Hashable {
    let id = UUID()
    let cityName: String
    let airportName: String
    let countryName: String
    let countryCode: String
    
    var flagEmoji: String {
        countryCode
            .uppercased()
            .unicodeScalars
            .compactMap { UnicodeScalar(127397 + $0.value) }
            .map { String($0) }
            .joined()
    }
}

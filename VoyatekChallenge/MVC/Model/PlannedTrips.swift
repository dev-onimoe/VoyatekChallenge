import Foundation

struct PlannedTrip {
    let id: Int
    let destination: String
    let startDate: String
    let durationDays: Int
}

struct Trip: Decodable {
    let country: String
    let city: String
    let startDate: String
    let endDate: String
    let tripName: String
    let tripVolume: String
}

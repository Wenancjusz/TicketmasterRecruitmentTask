
import SwiftUI
import Foundation

struct EventData: Codable {
    let name, id, type: String
    let url, locale: String
    let images: [Image]
    let dates: Dates
    let classifications: [Classification]
    let priceRanges: [PriceRange]?
    let seatmap: Seatmap?
    let embedded: Embedded

    enum CodingKeys: String, CodingKey {
        case name, id, type, url, locale, images, dates, classifications, priceRanges, seatmap
        case embedded = "_embedded"
    }

    struct Embedded: Codable {
        let venues: [Venue?]?
        let attractions: [Attraction?]?
    }
}

struct Image: Codable, Equatable, Hashable {
    let url: String?
}

struct Dates: Codable, Equatable {
    let start: Start

    struct Start: Codable, Equatable {
        let localDate: String
        let localTime: String?
    }
}

struct Classification: Codable, Equatable {
    let segment, genre: Genre
}

struct Genre: Codable, Equatable {
    let name: String
}

struct PriceRange: Codable, Equatable {
    let type, currency: String
    let min, max: Double
}

struct Seatmap: Codable, Equatable {
    let staticUrl, id: String
}

struct Venue: Codable, Equatable {
    let name, type, id: String?
    let url, locale: String?
    let postalCode, timezone: String?
    let city: City?
    let country: Country?
    let address: Address?

    enum CodingKeys: String, CodingKey {
        case name, type, id, url, locale, postalCode, timezone, city, country, address
    }

    struct Country: Codable, Equatable {
        let name, countryCode: String
    }

    struct Address: Codable, Equatable{
        let line1: String
    }
}

struct City: Codable, Equatable {
    let name: String
}

struct Attraction: Codable {
    let name: String

    enum CodingKeys: String, CodingKey {
        case name
    }
}

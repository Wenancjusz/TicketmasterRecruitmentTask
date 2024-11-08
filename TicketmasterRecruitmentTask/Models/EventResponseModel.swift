
import Foundation

struct Event: Codable, Equatable {
    let id: String
    let name: String
    let dates: Dates?
    let _embedded: Embedded?
    let images: [Image]?
    let place: Place?

    struct Dates: Codable, Equatable {
        let start: Start?

        struct Start: Codable, Equatable {
            let localDate: String?
            let dateTime: String?
        }
    }

    struct Embedded: Codable, Equatable {
        let venues: [Venue]?
    }

    struct Image: Codable, Equatable {
        let url: String?
    }

    struct Place: Codable, Equatable {
        let city: City?
        let name: String?
    }
}

struct EventResponse: Codable, Equatable {
    let _embedded: Embedded?

    struct Embedded: Codable, Equatable {
        let events: [Event]?
    }
}

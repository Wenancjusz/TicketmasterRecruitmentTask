
import Foundation
import SwiftUI

class EventDetailsViewModel: ObservableObject {
    @Published var eventDetails: EventData?

    private let networkService = NetworkService()

    func getFormattedTimeDate() -> String {
        return DateTimeFormatter.formatDateString(eventDetails?.dates.start.localDate)
            .appending(" ")
            .appending(DateTimeFormatter.formatTimeString(eventDetails?.dates.start.localTime))
    }

    func getEventName() -> String {
        return eventDetails?.name ?? "No Event name".localized()
    }

    func getPerformer() -> String {
        return eventDetails?.embedded.attractions?.first??.name ?? "Performer Name".localized()
    }
    
    func getEventType() -> String {
        return eventDetails?.type ?? "Unknown".localized()
    }

    func getFormattedCity() -> String {
        return eventDetails?.embedded.venues?.first??.city?.name ?? "No information".localized()
    }
    
    func getFormattedCountry() -> String {
        return eventDetails?.embedded.venues?.first??.country?.name ?? "No information".localized()
    }
    
    func getFormattedVenueName() -> String {
        return eventDetails?.embedded.venues?.first??.name ?? "No information".localized()
    }
    
    func getFormattedAddress() -> String {
        return eventDetails?.embedded.venues?.first??.address?.line1 ?? "No information".localized()
    }
    
    @MainActor
    func fetchEventDetails(eventId: String) {
        Task {
            do {
                eventDetails = try await networkService.fetchEventDetail(eventId: eventId)
            }
            catch {
                print("Error fetching event details: \(error.localizedDescription)")
            }
        }
    }
}

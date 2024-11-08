
import SwiftUI

class EventListViewModel: ObservableObject {

    @Published var events: [Event] = []
    @Published var isFetching = false

    private var currentPage = 0
    private let pageSize = 10
    private let networkService = NetworkService()

    @MainActor
    func fetchEvents() async {
        guard !isFetching else { return }
        isFetching = true

        do {
            let newEvents = try await networkService.fetchEvents()
            events.append(contentsOf: newEvents)
            currentPage += 1
        } catch {
            print("Error fetching event details: \(error.localizedDescription)")
        }

        isFetching = false
    }

    func loadMoreContentIfNeeded(currentItem item: Event) {
        if item == events.last && !isFetching {
            Task {
                await fetchEvents()
            }
        }
    }

    func getFormattedDate(_ event: Event) -> String {
        return DateTimeFormatter.formatDateString(event.dates?.start?.localDate)
    }

    func getFormattedCity(_ event: Event) -> String {
        return event._embedded?.venues?.first?.city?.name ?? event.place?.city?.name ?? "Not confirmed"
    }

    func getFormattedEventPlace(_ event: Event) -> String {
        return event._embedded?.venues?.first?.name ?? event.place?.name ?? "Not confirmed"
    }
}

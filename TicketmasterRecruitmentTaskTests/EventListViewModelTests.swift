
import XCTest
@testable import TicketmasterRecruitmentTask

class EventListViewModelTests: XCTestCase {

    func testGetFormattedDate() {
        let viewModel = EventListViewModel()
        let event = Event(id: "1", name: "Event 1", dates: Event.Dates(start: Event.Dates.Start(localDate: "2024-12-25", dateTime: nil)), _embedded: nil, images: nil, place: nil)
        let formattedDate = viewModel.getFormattedDate(event)
        XCTAssertEqual(formattedDate, "25-12-2024")
    }

    func testGetFormattedCity_EmbeddedVenue() {
        let viewModel = EventListViewModel()
        let venue = Venue(name: nil, type: nil, id: nil, url: nil, locale: nil, postalCode: nil, timezone: nil, city: City(name: "London"), country: nil, address: nil)
        let event = Event(id: "1", name: "Event 1", dates: nil, _embedded: Event.Embedded(venues: [venue]), images: nil, place: nil)
        XCTAssertEqual(viewModel.getFormattedCity(event), "London")
    }

    func testGetFormattedCity_Place() {
        let viewModel = EventListViewModel()
        let place = Event.Place(city: City(name: "Manchester"), name: "Place Name")
        let event = Event(id: "1", name: "Event 1", dates: nil, _embedded: nil, images: nil, place: place)
        XCTAssertEqual(viewModel.getFormattedCity(event), "Manchester")
    }

    func testGetFormattedCity_NoCityInfo() {
        let viewModel = EventListViewModel()
        let event = Event(id: "1", name: "Event 1", dates: nil, _embedded: nil, images: nil, place: nil)
        XCTAssertEqual(viewModel.getFormattedCity(event), "Not confirmed")
    }

    func testGetFormattedEventPlace_EmbeddedVenue() {
        let viewModel = EventListViewModel()
        let venue = Venue(name: "Venue 1", type: nil, id: nil, url: nil, locale: nil, postalCode: nil, timezone: nil, city: nil, country: nil, address: nil)
        let event = Event(id: "1", name: "Event 1", dates: nil, _embedded: Event.Embedded(venues: [venue]), images: nil, place: nil)
        XCTAssertEqual(viewModel.getFormattedEventPlace(event), "Venue 1")
    }

    func testGetFormattedEventPlace_Place() {
        let viewModel = EventListViewModel()
        let place = Event.Place(city: nil, name: "Place 1")
        let event = Event(id: "1", name: "Event 1", dates: nil, _embedded: nil, images: nil, place: place)
        XCTAssertEqual(viewModel.getFormattedEventPlace(event), "Place 1")
    }

    func testGetFormattedEventPlace_NoPlaceInfo() {
        let viewModel = EventListViewModel()
        let event = Event(id: "1", name: "Event 1", dates: nil, _embedded: nil, images: nil, place: nil)
        XCTAssertEqual(viewModel.getFormattedEventPlace(event), "Not confirmed")
    }
}

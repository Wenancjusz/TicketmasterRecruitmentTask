
import XCTest
@testable import TicketmasterRecruitmentTask

class EventDetailsViewModelTests: XCTestCase {

    let viewModel = EventDetailsViewModel()
    
    let mockEventDetails = EventData(name: "Event Name", id: "1", type: "Music", url: "https://example.com", locale: "en-US", images: [], dates: Dates(start: Dates.Start(localDate: "2024-11-15", localTime: "19:00:00")), classifications: [], priceRanges: nil, seatmap: nil, embedded: EventData.Embedded(venues: [
        Venue(name: "TestVenue", type: "testType", id: "2", url: "https://example.com/testVenue", locale: nil, postalCode: "00000", timezone: nil, city: City(name: "London"), country: Venue.Country(name: "England", countryCode: "UK"), address: Venue.Address(line1: "TestStreet"))], attractions: [Attraction(name: "Artist Name")]))
    
    func testGetFormattedTimeDate() {
        viewModel.eventDetails = mockEventDetails
        let formattedDateTime = viewModel.getFormattedTimeDate()
        XCTAssertEqual(formattedDateTime, "15-11-2024 19:00")
    }

    func testGetPerformer() {
        viewModel.eventDetails = mockEventDetails
        XCTAssertEqual(viewModel.getPerformer(), "Artist Name")
    }
    
    func testGetEventType() {
        viewModel.eventDetails = mockEventDetails
        XCTAssertEqual(viewModel.getEventType(), "Music")
    }
    
    func testGetFormattedCity() {
        viewModel.eventDetails = mockEventDetails
        XCTAssertEqual(viewModel.getFormattedCity(), "London")
    }
    
    func testGetFormattedCountry() {
        viewModel.eventDetails = mockEventDetails
        XCTAssertEqual(viewModel.getFormattedCountry(), "England")
    }
    
    func testGetFormattedVenueName() {
        viewModel.eventDetails = mockEventDetails
        XCTAssertEqual(viewModel.getFormattedVenueName(), "TestVenue")
    }
    
    func testGetFormattedAddress() {
        viewModel.eventDetails = mockEventDetails
        XCTAssertEqual(viewModel.getFormattedAddress(), "TestStreet")
    }
}

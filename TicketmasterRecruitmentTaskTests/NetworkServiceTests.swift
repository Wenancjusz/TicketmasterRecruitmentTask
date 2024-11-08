
import XCTest
@testable import TicketmasterRecruitmentTask

class NetworkServiceTests: XCTestCase {

    class MockNetworkService: NetworkService {
        func fetchMockData<T: Decodable>(from url: URL?) async throws -> T {
            if let url = url {
                if url.absoluteString.contains("/events.json") {
                    let mockData = try! JSONEncoder().encode(EventResponse(_embedded: EventResponse.Embedded(events: [Event(id: "1", name: "Mock Event", dates: nil, _embedded: nil, images: nil, place: nil)])))
                    return try! JSONDecoder().decode(T.self, from: mockData)
                } else if url.absoluteString.contains("/events/") {
                    let mockData = try! JSONEncoder().encode(EventData(name: "Mock Event Detail", id: "1", type: "Music", url: "", locale: "", images: [], dates: .init(start: .init(localDate: "", localTime: nil)), classifications: [], priceRanges: nil, seatmap: nil, embedded: .init(venues: nil, attractions: nil)))

                    return try! JSONDecoder().decode(T.self, from: mockData)
                } else {
                    throw NetworkError.invalidURL
                }
            } else {
                throw NetworkError.invalidURL
            }
        }
    }

    func testFetchEvents_success() async throws {
        let networkService = MockNetworkService()
        let events = try await (networkService.fetchMockData(from: URL(string: "/events.json")) as EventResponse)._embedded?.events
        XCTAssertEqual(events?.count ?? 0, 1)
        XCTAssertEqual(events?.first?.name, "Mock Event")
    }

    func testFetchEventDetail_success() async throws {
        let networkService = MockNetworkService()
        let eventDetails = try await (networkService.fetchMockData(from: URL(string: "/events/")) as EventData)
        XCTAssertEqual(eventDetails.name, "Mock Event Detail")
    }

    func testFetchEvents_invalidURL() async throws {
        let networkService = MockNetworkService()
        do {
            _ = try await networkService.fetchMockData(from: URL(string: "")) as String
            XCTFail("Expected NetworkError.invalidURL, but no error was thrown")
        } catch let error as NetworkError {
            XCTAssertEqual(error, NetworkError.invalidURL)
        } catch {
            XCTFail("Unexpected error thrown: \(error)")
        }
    }
}

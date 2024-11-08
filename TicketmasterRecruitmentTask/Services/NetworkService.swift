
import Foundation

enum NetworkError: Error, Equatable {
    case invalidURL
    case networkFailure(Error)
    case decodingFailure(Error)
    case unexpectedStatusCode(Int)

    static func == (lhs: NetworkError, rhs: NetworkError) -> Bool {
        switch (lhs, rhs) {
        case (.invalidURL, .invalidURL):
            return true
        case (.networkFailure(let lhsError), .networkFailure(let rhsError)):
            return lhsError.localizedDescription == rhsError.localizedDescription
        case (.decodingFailure(let lhsError), .decodingFailure(let rhsError)):
            return lhsError.localizedDescription == rhsError.localizedDescription
        case (.unexpectedStatusCode(let lhsCode), .unexpectedStatusCode(let rhsCode)):
            return lhsCode == rhsCode
        default:
            return false
        }
    }
}

class NetworkService {
    private var isFetching = false
    private var currentPage = 0
    private let pageSize = 10
    private let countryCode = "PL"

      func fetchEvents() async throws -> [Event] {
          guard !isFetching else { return [] }
          isFetching = true
          defer { isFetching = false }

          var urlComponents = URLComponents(string: Constants.baseURL.appending("/events.json"))
          urlComponents?.queryItems = [
              URLQueryItem(name: "apikey", value: Constants.apiKey),
              URLQueryItem(name: "size", value: "\(pageSize)"),
              URLQueryItem(name: "page", value: "\(currentPage)"),
              URLQueryItem(name: "countryCode", value: countryCode),
          ]

          guard let url = urlComponents?.url else {
              throw NetworkError.invalidURL
          }

          do {
              let eventResponse: EventResponse = try await fetchData(from: url)
              let newEvents = eventResponse._embedded?.events ?? []

              if !newEvents.isEmpty {
                  currentPage += 1
              }
              return newEvents
          } catch {
              print("Failed to fetch events: \(error)")
              throw error
          }
      }

      func fetchEventDetail(eventId: String) async throws -> EventData? {
          guard let url = URL(string: "\(Constants.baseURL)/events/\(eventId)?apikey=\(Constants.apiKey)") else {
              throw NetworkError.invalidURL
          }
          return try await fetchData(from: url)
      }

      private func fetchData<T: Decodable>(from url: URL) async throws -> T {
          do {
              let (data, response) = try await URLSession.shared.data(from: url)
              guard let httpResponse = response as? HTTPURLResponse,
                    (200...299).contains(httpResponse.statusCode) else {
                  throw NetworkError.unexpectedStatusCode((response as? HTTPURLResponse)?.statusCode ?? -1)
              }
              let decodedData = try JSONDecoder().decode(T.self, from: data)
              return decodedData
          } catch let decodingError as DecodingError {
              throw NetworkError.decodingFailure(decodingError)
          } catch {
              throw NetworkError.networkFailure(error)
          }
      }
}

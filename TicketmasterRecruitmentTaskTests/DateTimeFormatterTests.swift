
import XCTest
@testable import TicketmasterRecruitmentTask

class DateTimeFormatterTests: XCTestCase {

    func testFormatDateString_validInput() throws {
        let formattedDate = DateTimeFormatter.formatDateString("2024-11-15")
        XCTAssertEqual(formattedDate, "15-11-2024")
    }

    func testFormatDateString_invalidInput() throws {
        let formattedDate = DateTimeFormatter.formatDateString("invalid-date")
        XCTAssertEqual(formattedDate, "Data niepotwierdzona")
    }

    func testFormatDateString_nilInput() throws {
        let formattedDate = DateTimeFormatter.formatDateString(nil)
        XCTAssertEqual(formattedDate, "Data niepotwierdzona")
    }

    func testFormatTimeString_validInput() throws {
        let formattedTime = DateTimeFormatter.formatTimeString("14:30:00")
        XCTAssertEqual(formattedTime, "14:30")
    }

    func testFormatTimeString_invalidInput() throws {
        let formattedTime = DateTimeFormatter.formatTimeString("invalid-time")
        XCTAssertEqual(formattedTime, "Czas niepotwierdzony")
    }

    func testFormatTimeString_nilInput() throws {
        let formattedTime = DateTimeFormatter.formatTimeString(nil)
        XCTAssertEqual(formattedTime, "Czas niepotwierdzony")
    }
}

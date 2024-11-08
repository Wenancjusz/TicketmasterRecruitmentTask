
import Foundation

struct DateTimeFormatter {
    private static let yyyyMMdd: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()

    private static let ddMMyyyy: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        return formatter
    }()

    private static let HHmmSS: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        return formatter
    }()

    private static let HHmm: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }()

    static func formatDateString(_ dateString: String?) -> String {
        guard let dateString = dateString,
              let date = yyyyMMdd.date(from: dateString) else {
            return "Date not confirmed".localized()
        }
        return ddMMyyyy.string(from: date)
    }

    static func formatTimeString(_ timeString: String?) -> String {
        guard let timeString = timeString,
              let date = HHmmSS.date(from: timeString) else {
            return "Time not confirmed".localized()
        }
        return HHmm.string(from: date)
    }
}


import Foundation

extension String {
    func localized(
        table: String = Constants.defaultLocalization,
        bundle: Bundle = .main,
        comment: String = ""
    ) -> String {
        NSLocalizedString(self, tableName: table, bundle: bundle, value: self, comment: comment)
    }
}

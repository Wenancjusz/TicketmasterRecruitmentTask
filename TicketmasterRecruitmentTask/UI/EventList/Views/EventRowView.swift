
import SwiftUI

struct EventRowView: View {
    private let event: Event
    private let viewModel: EventListViewModel

    init(event: Event, _ viewModel: EventListViewModel) {
        self.event = event
        self.viewModel = viewModel
    }

    var body: some View {
        VStack(alignment: .leading) {
            Text(event.name)
                .font(.headline)
            FormattedSubHeadline("Date: %@", value: viewModel.getFormattedDate(event))
            FormattedSubHeadline("City: %@", value: viewModel.getFormattedCity(event))
            FormattedSubHeadline("Event place: %@", value: viewModel.getFormattedEventPlace(event))

            if let image = event.images?.first, let url = URL(string: image.url ?? "") {
                AsyncImage(url: url) { image in
                    image.resizable().scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: DesignConstants.defaultFrame)
                .cornerRadius(DesignConstants.defaultCornerRadius)
            }
        }
        .padding(.vertical)
    }

    struct FormattedSubHeadline: View {
        private let key: String
        private let value: String

        init(_ key: String, value: String) {
           self.key = key
           self.value = value
       }

        var body: some View {
            Text(String(format: key.localized(), value))
                .font(.subheadline)
        }
    }
}

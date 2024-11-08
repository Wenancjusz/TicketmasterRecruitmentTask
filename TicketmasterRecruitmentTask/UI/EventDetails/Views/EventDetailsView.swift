
import SwiftUI

struct EventDetailsView: View {
    @StateObject private var viewModel = EventDetailsViewModel()
    private var eventId: String

    init(eventId: String) {
        self.eventId = eventId
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: DesignConstants.defaultPadding) {

                DividerTitleText(viewModel.getEventName())

                DividerText("Performer: %@", value: viewModel.getPerformer())
                DividerText("Date & Time: %@", value: viewModel.getFormattedTimeDate())
                DividerText("Type: %@", value: viewModel.getEventType())
                LocalizationGroup(viewModel: viewModel)

                if let priceRange = viewModel.eventDetails?.priceRanges?.first {
                    Text("Price Range: \(priceRange.currency) \(String(format: "%.2f", priceRange.min)) - \(String(format: "%.2f", priceRange.max))")
                        .font(.headline)
                }

                Divider()

                if let galleryImages = viewModel.eventDetails?.images {
                    Text("Gallery").font(.headline)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 8) {
                            ForEach(galleryImages, id: \.self) { image in
                                if let url = image.url {
                                    AsyncImage(url: URL(string: url)) { image in
                                        image.resizable().scaledToFill()
                                    } placeholder: {
                                        ProgressView()
                                    }
                                    .frame(width: 200, height: 150)
                                    .cornerRadius(8)
                                }
                            }
                        }
                    }
                }

                Divider()

                if let seatingMapUrl = viewModel.eventDetails?.seatmap?.staticUrl, let url = URL(string: seatingMapUrl) {
                    Text("Seating Map").font(.headline)
                    AsyncImage(url: url) { image in
                        image.resizable().scaledToFit()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: UIScreen.main.bounds.width*0.95)
                    .cornerRadius(8)
                }
            }
            .padding()
        }
        .task {
            let pv = ProgressView()
            viewModel.fetchEventDetails(eventId: eventId)
            _ = pv.hidden()
        }
        .navigationTitle("Event Details")
    }

    private struct LocalizationGroup: View {
        @StateObject var viewModel: EventDetailsViewModel

        var body: some View {
            VStack(alignment: .leading, spacing: DesignConstants.smallPadding) {
                Text("Location".localized())
                    .font(.headline)
                
                LocationText("Country: %@".localized(), value: viewModel.getFormattedCountry())
                LocationText("City: %@".localized(), value: viewModel.getFormattedCity())
                LocationText("Venue: %@".localized(), value: viewModel.getFormattedVenueName())
                LocationText("Address: %@".localized(), value: viewModel.getFormattedAddress())
            }
            Divider()
        }
    }

    private struct FormattedText: View {
        private let key: String
        private let value: String

        init(_ key: String, value: String) {
           self.key = key
           self.value = value
       }

        var body: some View {
            VStack(spacing: 0) {
                Text(String(format: key.localized(), value))
           }
        }
    }

    private struct DividerText: View {
        private let key: String
        private let value: String

        init(_ key: String, value: String) {
           self.key = key
           self.value = value
       }

        var body: some View {
            VStack(alignment: .leading, spacing: DesignConstants.defaultPadding) {
                FormattedText(key, value: value)
                Divider()
            }
        }
    }

    private struct DividerTitleText: View {
        private let text: String

        init(_ text: String) {
           self.text = text
       }

        var body: some View {
            VStack(alignment: .leading, spacing: DesignConstants.defaultPadding) {
                Text(text)
                    .font(.title2)
                Divider()
            }
        }
    }
    
    private struct LocationText: View {
        private let key: String
        private let value: String

        init(_ key: String, value: String) {
           self.key = key
           self.value = value
       }

        var body: some View {
            Text(String(format: key.localized(), value))
        }
    }
}

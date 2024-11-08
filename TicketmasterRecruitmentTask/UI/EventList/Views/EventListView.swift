
import SwiftUI

struct EventListView: View {
    @StateObject private var viewModel = EventListViewModel()

    var body: some View {
        NavigationView {
            Group {
                if viewModel.isFetching && viewModel.events.isEmpty {
                    LoadingView(message: "Loading events".localized())
                } else {
                    ListView(viewModel, loadMoreAction: viewModel.loadMoreContentIfNeeded)
                }
            }
            .navigationTitle("Ticketmaster".localized())
            .task {
                await viewModel.fetchEvents()
            }
        }
    }

    private struct LoadingView: View {
        private let message: String

        init(message: String) {
            self.message = message
        }

        var body: some View {
            VStack {
                ProgressView(message)
                    .progressViewStyle(CircularProgressViewStyle())
                    .scaleEffect(DesignConstants.defaultScaleEffect)
            }
        }
    }

    private struct ListView: View {
        @ObservedObject private var viewModel: EventListViewModel
        private let loadMoreAction: (Event) -> Void

        init(_ viewModel: EventListViewModel, loadMoreAction: @escaping (Event) -> Void) {
            self.viewModel = viewModel
            self.loadMoreAction = loadMoreAction
        }

        var body: some View {
            List {
                ForEach(viewModel.events, id: \.id) { event in
                    NavigationLink(destination: EventDetailsView(eventId: event.id)) {
                        EventRowView(event: event, viewModel)
                    }
                    .onAppear {
                        loadMoreAction(event)
                    }
                }
                if viewModel.isFetching {
                    LoadingMoreView()
                }
            }
        }

        private struct LoadingMoreView: View {
            var body: some View {
                HStack {
                    Spacer()
                    ProgressView("Loading more events...".localized())
                    Spacer()
                }
            }
        }
    }
}

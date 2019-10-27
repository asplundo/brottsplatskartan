import Foundation
import Combine
import Fluxus

struct RootState {
    var areasState = AreasState()
    var eventsState = EventsState()
}

struct AreasState: FluxState {
    var areas: [Area] = []
    var selectedArea: Area?
}

struct EventsState: FluxState {
    var events: [Event] = []
    var selectedEvent: Event?
}

enum AreasMutation: Mutation {
    case areas([Area])
}

enum EventsMutation: Mutation {
    case events([Event])
}

struct AreasCommiter: Committer {
    func commit(state: AreasState, mutation: AreasMutation) -> AreasState {
        var state = state
        switch mutation {
        case .areas(let areas):
            state.areas = areas
        }
        return state
    }
}

struct EventsCommiter: Committer {
    func commit(state: EventsState, mutation: EventsMutation) -> EventsState {
        var state = state
        switch mutation {
        case .events(let events):
            state.events = events
        }
        return state
    
    }
}

enum FetchAction: Action {
    case areas
    case events(area: String, page: Int)
}

class FetchDispatcher: Dispatcher {
    var commit: (Mutation) -> Void
    
    init(commit: @escaping (Mutation) -> Void) {
        self.commit = commit
    }
    
    func dispatch(action: FetchAction) {
        switch action {
        case .areas:
            APIManager.shared.fetchAreas() { result in
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let data):
                    self.commit(AreasMutation.areas(data.areas))
                }
            }
        case .events(let area, let page):
            APIManager.shared.fetchEvents(for: area, page: page) { result in
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let data):
                    self.commit(EventsMutation.events(data))
                }
            }
        }
    }
    
}



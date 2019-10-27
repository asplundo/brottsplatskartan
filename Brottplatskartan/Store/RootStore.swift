import Foundation
import Fluxus

class RootStore: ObservableObject {
    
    @Published var state = RootState()
    
    func commit(_ mutation: Mutation) {
        switch mutation {
        case is AreasMutation:
            state.areasState = AreasCommiter().commit(state: state.areasState, mutation: mutation as! AreasMutation)
        case is EventsMutation:
            state.eventsState = EventsCommiter().commit(state: state.eventsState, mutation: mutation as! EventsMutation)
        default:
            break
        }
    }
    
    func dispatch(_ action: Action) {
        switch action {
        case is FetchAction:
            FetchDispatcher(commit: self.commit).dispatch(action: action as! FetchAction)
        default:
            break
        }
    }
    
}

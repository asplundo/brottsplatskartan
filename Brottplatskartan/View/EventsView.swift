import SwiftUI

struct EventsView: View {
    
    @EnvironmentObject var store: RootStore
    var area: String
    
    var body: some View {
        List(store.state.eventsState.events) { event in
            NavigationLink(destination: Text(event.description)) {
                EventRow(event: event)
                    .padding(.bottom)
            }
        }
        .onAppear {
            self.store.dispatch(FetchAction.events(area: self.area, page: 1))
        }
    }
}

struct EventsView_Previews: PreviewProvider {
    static var previews: some View {
        EventsView(area: "area")
    }
}

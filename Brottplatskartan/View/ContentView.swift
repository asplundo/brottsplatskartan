import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var store: RootStore
    
    var body: some View {
        NavigationView {
            List(store.state.areasState.areas) { area in
                NavigationLink(destination: EventsView(area: area.name)) {
                    HStack {
                        Text(area.name)
                        Spacer()
                        Text("\(area.numEvents)")
                    }
                }
            }
            .onAppear(perform: {
                print("ContetView onAppear")
                self.store.commit(EventsMutation.events([]))
                self.store.dispatch(FetchAction.areas)
            })
            .navigationBarTitle("Brottsplatskartan")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

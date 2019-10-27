import SwiftUI

struct EventRow: View {
    
    var event: Event
    
    var body: some View {
        VStack(alignment: .leading) {
            MapView(longitude: event.longitude, latitude: event.latitude).frame(height: 200)
            Text("\(event.type)")
            Text("\(event.location)")
        }
    }
}

struct EventRow_Previews: PreviewProvider {
    static let event = Event(id: 1, date: Date(), type: "type", description: "description", content: "content", longitude: 1.0, latitude: 1.0, location: "location", northEastLat: "1.0", northEastLong: "1.0", southWestLat: "1.0", southWestLong: "1.0")
    
    static var previews: some View {

        EventRow(event: event)
    }
}

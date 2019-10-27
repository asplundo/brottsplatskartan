import Foundation

struct EventsResponse: Codable {
  var data: [Event]
}

struct Event: Codable, Identifiable {
  
  static var dateFormat = "yyyy-MM-dd HH:mm"
  
  var id: Int
  var date: Date
  var type: String
  var description: String
  var content: String
  var longitude: Double
  var latitude: Double
  var location: String
  var northEastLat: String
  var northEastLong: String
  var southWestLat: String
  var southWestLong: String
  
  var dateString: String {
    get {
      let df = DateFormatter()
      df.dateFormat = Event.dateFormat
      return df.string(from: date)
    }
  }
  
  var shortLocation: String {
    get {
      return location.replacingOccurrences(of: "(,.*)", with: "", options: .regularExpression)
    }
  }
  
  var cleanContent: String {
    get {
      return content.replacingOccurrences(of: "<[^>]*>", with: "", options: .regularExpression)
    }
  }
  
  enum CodingKeys: String, CodingKey {
    case id
    case date = "pubdate_iso8601"
    case type = "title_type"
    case description
    case content
    case longitude = "lng"
    case latitude = "lat"
    case location = "location_string"
    case northEastLat = "viewport_northeast_lat"
    case northEastLong = "viewport_northeast_lng"
    case southWestLat = "viewport_southwest_lat"
    case southWestLong = "viewport_southwest_lng"
  }
}

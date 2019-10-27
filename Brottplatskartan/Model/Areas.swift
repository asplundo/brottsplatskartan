import Foundation

struct AreasResponseWrapper: Decodable {
    var data: AreasWrapper
}

struct AreasWrapper: Decodable {
    var areas: [Area]
}

struct Area: Decodable, Identifiable {
    var id = UUID().uuidString
    var name: String
    var numEvents: Int
    
    private enum CodingKeys: String, CodingKey {
        case name = "administrative_area_level_1"
        case numEvents
    }
}

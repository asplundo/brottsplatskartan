import Foundation
import Combine

class APIManager {
    
    static let shared = APIManager()
    private var areasCancellable: AnyCancellable?
    private var eventsCancellable: AnyCancellable?
    
    private init() {
        
    }
    
    var cancellable: AnyCancellable?
    var decoder: JSONDecoder {
        let decoder = JSONDecoder()
//        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }
    
    func fetchAreas(callback: @escaping (Result<AreasWrapper, Error>) -> Void){
        guard let url = areasUrlComponents.url else {
            fatalError("Could not create url for areas")
        }
        let publisher = URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: AreasResponseWrapper.self, decoder: self.decoder)
            .receive(on: DispatchQueue.main)
        
        self.areasCancellable = publisher.sink(receiveCompletion: { completion in
            switch completion {
            case .failure(let error):
                callback(.failure(error))
            case .finished:
                self.cancellable = nil
            }
        }, receiveValue: { value in
            callback(.success(value.data))
        })
    }
    
    func fetchEvents(for area: String, page: Int = 1, callback: @escaping (Result<[Event], Error>) -> Void) {
        guard let url = getEventsUrlComponents(for: area, page: page).url else {
            fatalError("Could not create url for events")
        }
        print(url.absoluteString)
        let publisher = URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: EventsResponse.self, decoder: self.decoder)
            .receive(on: DispatchQueue.main)
        
        self.eventsCancellable = publisher.sink(receiveCompletion: { completion in
            switch completion {
            case.failure(let error):
                callback(.failure(error))
            case .finished:
                self.eventsCancellable = nil
            }
        }, receiveValue: { value in
            callback(.success(value.data))
        })
    }
    
    private var areasUrlComponents: URLComponents {
        var components = baseUrlComponents
        components.path = "/api/areas"
        return components
    }
    
    private func getEventsUrlComponents(for area: String, page: Int) -> URLComponents {
        var components = baseUrlComponents
        components.path = "/api/events"
        components.queryItems?.append(URLQueryItem(name: "area", value: area))
        components.queryItems?.append(URLQueryItem(name: "page", value: "\(page)"))
        components.queryItems?.append(URLQueryItem(name: "limit", value: "\(50)"))
        
        return components
    }
    
    private var baseUrlComponents: URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "brottsplatskartan.se"
        let appQueryItem = URLQueryItem(name: "app", value: "test")
        components.queryItems = [appQueryItem]
        return components
    }
    
}

struct FetchEventsItem {
    let page: Int
    let limit: Int
}


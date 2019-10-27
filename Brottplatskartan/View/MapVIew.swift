import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    
    let longitude: Double
    let latitude: Double
    
    
    func makeUIView(context: Context) -> MKMapView {
        MKMapView(frame: .zero)
    }
    
    
    func updateUIView(_ view: MKMapView, context: Context) {
        view.isUserInteractionEnabled = false
        let coordinate = CLLocationCoordinate2D(
            latitude: self.latitude, longitude: self.longitude)
        
        if view.annotations.count == 0 {
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            view.addAnnotation(annotation)
        }

        let radius: CLLocationDistance = 500
        let coordinateregion = MKCoordinateRegion(center: coordinate, latitudinalMeters: radius, longitudinalMeters: radius)
        view.setRegion(coordinateregion, animated: true)
    }
    
}

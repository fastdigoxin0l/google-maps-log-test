import GoogleMaps
import SwiftUI

struct MapViewControllerBridge: UIViewControllerRepresentable {
    @Binding var camera: GMSCameraPosition
        
    func makeUIViewController(context: Context) -> MapViewController {
        let uiViewController = MapViewController(camera: camera)
        return uiViewController
    }
    
    func updateUIViewController(_ uiViewController: MapViewController, context: Context) {
        uiViewController.map.camera = camera
    }
}

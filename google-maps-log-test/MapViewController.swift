import GoogleMaps
import UIKit

class MapViewController: UIViewController {
    let map = GMSMapView()
    
    convenience init(camera: GMSCameraPosition) {
        self.init()
        map.camera = camera
    }
    
    override func loadView() {
        super.loadView()
        self.view = map
    }
}

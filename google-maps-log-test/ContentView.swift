import SwiftUI
import GoogleMaps

struct ContentView: View {
    @State var camera = GMSCameraPosition(latitude: 51.178832, longitude: -1.826461, zoom: 20.0, bearing: 0.0, viewingAngle: 0)
    let timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()

    var body: some View {
        MapViewControllerBridge(camera: $camera)
            .onReceive(timer) { _ in
                camera = GMSCameraPosition(
                    target: camera.target,
                    zoom: camera.zoom,
                    bearing: (camera.bearing + 1).truncatingRemainder(dividingBy: 360),
                    viewingAngle: camera.viewingAngle)
            }
    }
}

#Preview {
    ContentView()
}

import SwiftUI

@main
struct google_maps_log_testApp: App {
    @UIApplicationDelegateAdaptor private var appDelegate: AppDelegate

    let timerEverySecond = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .onReceive(timerEverySecond) { _ in
                    let fm = FileManager.default
                    guard let cacheDirectory = fm.urls(for: .cachesDirectory, in: .userDomainMask).first else { return }
                    let clearcutLoggerURL = cacheDirectory.appendingPathComponent("CCTClearcutLogger", isDirectory: true)
                    let size = getSize(for: clearcutLoggerURL)
                    if size < 1024*1024 {
                        print("\(size/1024) KB")
                    } else {
                        print("\(size/1024/1024) MB")
                    }
                }
        }
    }
    
    func getSize(for url: URL) -> Int64 {
        let contents: [URL]
        do {
            contents = try FileManager.default.contentsOfDirectory(at: url, includingPropertiesForKeys: [.fileSizeKey, .isDirectoryKey])
        } catch {
            return 0
        }

        var size: Int64 = 0

        for url in contents {
            let isDirectoryResourceValue: URLResourceValues
            do {
                isDirectoryResourceValue = try url.resourceValues(forKeys: [.isDirectoryKey])
            } catch {
                continue
            }
        
            if isDirectoryResourceValue.isDirectory == true {
                size += getSize(for: url)
            } else {
                let fileSizeResourceValue: URLResourceValues
                do {
                    fileSizeResourceValue = try url.resourceValues(forKeys: [.fileSizeKey])
                } catch {
                    continue
                }
            
                let fileSize = fileSizeResourceValue.fileSize ?? 0
                size += Int64(fileSize)
            }
        }
        
        return size
    }
}

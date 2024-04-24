import UIKit
import Flutter
import WatchConnectivity

extension FlutterError: Error {}

private class WatchCounterHostAPIImpl: WatchCounterHostAPI {
    let session: WCSession
    
    init(session: WCSession) {
        self.session = session
    }
    
    func increment() throws {
        session.sendMessage(["method": "increment"], replyHandler: nil)
    }
    
    func decrement() throws {
        session.sendMessage(["method": "decrement"], replyHandler: nil)
    }
    
    func setCounter(counter: Int64) throws {
        session.sendMessage(["method": "setCount", "data": counter], replyHandler: nil)
    }
}

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    var session: WCSession?
    var flutterWatchAPI: WatchCounterFlutterAPI?
    
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        GeneratedPluginRegistrant.register(with: self)
        
        
        if WCSession.isSupported() {
            session = WCSession.default;
            session?.delegate = self;
            session?.activate();
            
            let controller = window?.rootViewController as! FlutterViewController
            let api: WatchCounterHostAPI = WatchCounterHostAPIImpl(session: session!)
            
            WatchCounterHostAPISetup.setUp(binaryMessenger: controller.binaryMessenger, api: api)
            flutterWatchAPI = WatchCounterFlutterAPI(binaryMessenger: controller.binaryMessenger)
        }
        
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}

extension AppDelegate: WCSessionDelegate {
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) { }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        print("Session Watch Become Inactive")
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        print("Session Watch Deactivate")
    }
    
    // Receive a message from watch
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        Task {
            guard let method = message["method"] as? String else {
                return
            }
            if method == "increment" {
                self.flutterWatchAPI?.increment() { result in
                    switch result {
                    case .success(_):
                        print("Increment on Flutter - Success")
                    case .failure(let error):
                        print("Increment on Flutter - Error: \(error.description)")
                    }
                }
            } else {
                self.flutterWatchAPI?.decrement() { result in
                    switch result {
                    case .success(_):
                        print("Decrement on Flutter - Success")
                    case .failure(let error):
                        print("Decrement on Flutter - Error: \(error.description)")
                    }
                }
            }
        }
    }
}

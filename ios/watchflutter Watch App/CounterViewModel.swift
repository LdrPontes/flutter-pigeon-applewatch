//
//  CounterViewModel.swift
//  watchflutter Watch App
//
//  Created by Leandro Pontes Berleze on 23/04/24.
//

import Foundation
import WatchConnectivity

@MainActor
class CounterViewModel: NSObject, ObservableObject {
    @Published var count: Int = 0
    
    var session: WCSession
    
    init(session: WCSession = .default) {
        self.session = session
        super.init()
        self.session.delegate = self
        session.activate()
    }
    
    func increment(_ sendMessage: Bool = true) {
        count = count + 1
        if sendMessage {
            session.sendMessage(["method": "increment"], replyHandler: nil)
        }
    }
    
    func decrement(_ sendMessage: Bool = true) {
        count = count - 1
        if sendMessage {
            session.sendMessage(["method": "decrement"], replyHandler: nil)
        }
    }
}

extension CounterViewModel: WCSessionDelegate {
#if os(iOS)
    public func sessionDidBecomeInactive(_ session: WCSession) { }
    public func sessionDidDeactivate(_ session: WCSession) { }
#endif
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: (any Error)?) {}
    
    // Receive message From AppDelegate.swift that send from iOS devices
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        Task {
            guard let method = message["method"] as? String else {
                return
            }
            
            switch method {
            case "increment":
                self.increment(false)
            case "decrement":
                self.decrement(false)
            case "setCount":
                self.count = message["data"] as! Int
            default:
                print("None")
            }
        }
    }
    
}

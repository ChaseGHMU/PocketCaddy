//
//  PlayInterfaceController.swift
//  PocketCaddy
//
//  Created by Chase Allen on 3/9/18.
//  Copyright © 2018 Chase Allen. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity


class PlayInterfaceController: WKInterfaceController, WCSessionDelegate {

    @IBOutlet var watchLabel: WKInterfaceLabel!
    
    var watchSession: WCSession? {
        didSet {
            if let session = watchSession {
                session.delegate = self
                session.activate()
            }
        }
    }
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        watchSession = WCSession.default
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        if(WCSession.isSupported()) {
            let session = WCSession.default
            session.delegate = self
            session.activate()
        }
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        print("watch received data")
        let text = message["message"] as? String
        if let text = text{
            watchLabel.setText(text)
        }
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        
    }

}

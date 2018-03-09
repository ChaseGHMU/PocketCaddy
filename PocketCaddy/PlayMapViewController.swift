//
//  PlayMapViewController.swift
//  PocketCaddy
//
//  Created by Chase Allen on 3/8/18.
//  Copyright © 2018 Chase Allen. All rights reserved.
//

import UIKit
import MapKit
import WatchConnectivity

class PlayMapViewController: UIViewController, WCSessionDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.mapType = .satellite
        if WCSession.isSupported() {
            let session = WCSession.default
            session.delegate = self
            session.activate()
            sendData()
        }
        // Do any additional setup after loading the view.
    }
    
    func sendData() {
        if WCSession.default.isReachable {
            print("data sent")
            let message = ["message": "hello"]
            WCSession.default.sendMessage(message, replyHandler: nil, errorHandler: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

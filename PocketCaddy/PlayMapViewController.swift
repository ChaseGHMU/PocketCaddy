//
//  PlayMapViewController.swift
//  PocketCaddy
//
//  Created by Chase Allen on 3/8/18.
//  Copyright © 2018 Chase Allen. All rights reserved.
//

import UIKit
import MapKit

class PlayMapViewController: UIViewController, MKMapViewDelegate {


    @IBOutlet weak var mapView: MKMapView!
    
    var holes: [Holes] = []
    var hole: Int = 0
    var courseId: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.mapType = .satellite
        self.title = "Test"
        if let courseId = courseId {
            PocketCaddyData.getHoles(courseId: courseId, completionHandler: {result in
                self.holes = result
            })
        }
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getPoints(hole)
    }
    
    @IBAction func nextHole(_ sender: Any) {
        if hole < 18{
            hole += 1
            getPoints(hole)
        }
    }

    func getPoints(_ hole:Int){
        let holeNum = holes[hole]
        let teelocation = CLLocationCoordinate2D(latitude: holeNum.teeX, longitude: holeNum.teeY)
        let greenlocation = CLLocationCoordinate2D(latitude: holeNum.greenX, longitude: holeNum.greenY)
        createHoleMap(teeLocation: teelocation, greenLocation: greenlocation)
    }
    
    func createHoleMap(teeLocation: CLLocationCoordinate2D, greenLocation: CLLocationCoordinate2D){
        self.mapView.removeAnnotations(self.mapView.annotations)
        let sourcePlacemark = MKPlacemark(coordinate: teeLocation)
        let destPlacemark = MKPlacemark(coordinate: greenLocation)

        let sourceAnnotation = MKPointAnnotation()
        
        if let location = sourcePlacemark.location {
            sourceAnnotation.coordinate = location.coordinate
        }
        
        let destinationAnnotation = MKPointAnnotation()
        
        if let location = destPlacemark.location {
            destinationAnnotation.coordinate = location.coordinate
        }
        
        self.mapView.showAnnotations([sourceAnnotation,destinationAnnotation], animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

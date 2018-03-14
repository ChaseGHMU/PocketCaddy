//
//  PlayMapViewController.swift
//  PocketCaddy
//
//  Created by Chase Allen on 3/8/18.
//  Copyright © 2018 Chase Allen. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class PlayMapViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var distanceLabel: UILabel!
    
    @IBOutlet weak var mapView: MKMapView!
    
    var holes: [Holes] = []
    var hole: Int = 0
    var courseId: String?
    var courseName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.mapType = .satellite
        if let courseId = courseId, let courseName = courseName {
            PocketCaddyData.getHoles(courseId: courseId, completionHandler: { result in
                self.holes = result
            })
            self.title = courseName
        }
        mapView.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getPoints(hole)
    }
    
    @IBAction func nextHole(_ sender: Any) {
        if hole < 17 {
            hole += 1
            getPoints(hole)
        }else{
            hole = 0
            getPoints(hole)
        }
    }
    
    @IBAction func prevHole(_ sender: Any) {
        if hole > 0{
            hole -= 1
            getPoints(hole)
        }else{
            hole = 17
            getPoints(hole)
        }
    }
    
    
    func getDistance(locationOne: CLLocationCoordinate2D, locationTwo: CLLocationCoordinate2D) -> Double {
        let x = CLLocation(latitude: locationOne.latitude, longitude: locationOne.longitude)
        let y = CLLocation(latitude: locationTwo.latitude, longitude: locationTwo.longitude)
        
        return x.distance(from: y)
    }

    func getPoints(_ hole:Int){
        let holeNum = holes[hole]
        let teelocation = CLLocationCoordinate2D(latitude: holeNum.teeX, longitude: holeNum.teeY)
        let greenlocation = CLLocationCoordinate2D(latitude: holeNum.greenX, longitude: holeNum.greenY)
        var dist = getDistance(locationOne: teelocation, locationTwo: greenlocation)
        dist.round(.toNearestOrAwayFromZero)
        distanceLabel.text = "\(dist) Yards"
        
        createHoleMap(teeLocation: teelocation, greenLocation: greenlocation)
    }
    
    func createHoleMap(teeLocation: CLLocationCoordinate2D, greenLocation: CLLocationCoordinate2D){
        self.mapView.removeAnnotations(self.mapView.annotations)
        let sourcePlacemark = MKPlacemark(coordinate: teeLocation)
        let destPlacemark = MKPlacemark(coordinate: greenLocation)
        
        if let location1 = sourcePlacemark.location, let location2 = destPlacemark.location  {
            let sourceAnnotation = FlagAnnotation(coordinate: location1.coordinate)
            sourceAnnotation.imageName = "TransparentPin.png"
            let destinationAnnotation = FlagAnnotation(coordinate: location2.coordinate)
            destinationAnnotation.imageName = "HoleMarkerRed.png"
            let dest = MKAnnotationView(annotation: destinationAnnotation, reuseIdentifier: "pin")
            let source = MKAnnotationView(annotation: sourceAnnotation, reuseIdentifier: "pin")
            self.mapView.showAnnotations([source.annotation!,dest.annotation!], animated: true)
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let reuseIdentifier = "pin"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier)
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseIdentifier)
            annotationView?.canShowCallout = true
        } else {
            annotationView?.annotation = annotation
        }
        
        let cpa = annotation as! FlagAnnotation
        annotationView?.image = UIImage(named: cpa.imageName!)!
        
        return annotationView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

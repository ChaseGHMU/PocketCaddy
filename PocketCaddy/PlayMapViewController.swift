//
//  PlayMapViewController.swift
//  PocketCaddy
//
//  Created by Chase Allen on 3/8/18.
//  Copyright © 2018 Chase Allen. All rights reserved.
//

import UIKit
import MapKit
import Alamofire
import CoreLocation

class PlayMapViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var distanceLabel: UILabel!
    
    @IBOutlet weak var mapView: MKMapView!
    
    var holes: [Holes] = []
    var hole: Int = 0
    var courseId: String?
    var courseName: String?
    var gameId: String?
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.mapType = .satellite
        if let courseId = courseId, let userId = defaults.string(forKey: "userId") {
            
            let params: Parameters = [
                "courseId": courseId,
                "userId": userId
            ]
            
            PocketCaddyData.getHoles(courseId: courseId, completionHandler: { result in
                self.holes = result
                self.getPoints(self.hole)
            })
            
            PocketCaddyData.post(table: .games, parameters: params, login: false, completionHandler: { (dict, string, response) in
                if let dict = dict, let gameId = dict["gameId"] {
                    self.gameId = "\(gameId)"
                }
            })
            self.title = "Hole \(hole+1)"
        }

        let rightButton = UIBarButtonItem.init(title: "Scorecard", style: .done, target: self, action: #selector(scorecardAction(sender:)))
        self.navigationItem.rightBarButtonItem = rightButton
        mapView.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    @objc func scorecardAction(sender: UIBarButtonItem){
        performSegue(withIdentifier: "scorecard", sender: self)
    }
    
    @IBAction func nextHole(_ sender: Any) {
        if hole < 17 {
            hole += 1
            self.title = "Hole \(hole+1)"
            getPoints(hole)
        }else{
            hole = 0
            self.title = "Hole \(hole+1)"
            getPoints(hole)
        }
        performSegue(withIdentifier: "addScore", sender: self)
    }
    
    @IBAction func prevHole(_ sender: Any) {
        if hole > 0{
            hole -= 1
            self.title = "Hole \(hole+1)"
            getPoints(hole)
        }else{
            hole = 17
            self.title = "Hole \(hole+1)"
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? addScoreViewController{
            if hole == 0 {
                hole = 18
            }
            destination.holeId = holes[hole-1].holeID
            destination.gameId = gameId
        }
        if let destination = segue.destination as? PlayScorecardTableViewController{
            destination.gameId = gameId
        }
    }
    
}

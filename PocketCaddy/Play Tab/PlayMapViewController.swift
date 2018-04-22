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

class PlayMapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var distanceLabel: UILabel!
    
    @IBOutlet weak var mapView: MKMapView!
    
    var holes: [Holes] = []
    var wind = [Double]()
    var hole: Int = 0
    var courseId: String?
    var courseName: String?
    var gameId: String?
    let defaults = UserDefaults.standard
    var userLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(0,0)
    
    //Set the current position manually for testing Triple Lake Golf Club-->Latitude:38.479188  Longitude -90.142844
    //corelocation manager
    let manager=CLLocationManager()
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations[0]
        
        let span:MKCoordinateSpan = MKCoordinateSpanMake(0.01,0.01)
        
        let myLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude,location.coordinate.longitude)
        let region:MKCoordinateRegion = MKCoordinateRegionMake(myLocation, span)
        mapView.setRegion(region, animated: true)
        
        self.mapView.showsUserLocation = true
        
        if let currentLocation = locations.first {
            print(currentLocation.coordinate)
        }
        userLocation = myLocation;
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.mapType = .satellite
        if let courseId = courseId, let userId = defaults.string(forKey: "userId") {
            
            let params: Parameters = [
                "courseId": courseId,
                "userId": userId
            ]
            PocketCaddyData.getWeather(zip: "65201", completionHandler: { wind in
                self.wind = wind
            })
            
            print(wind)
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
        //    mapView.delegate = self
        
        // Do any additional setup after loading the view.
        navigationController?.navigationBar.barTintColor = UIColor(red: 1, green: 0.9725, blue: 0.8667, alpha: 1.0)
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
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
    
    func metersPerSecondToMPH(metersPerSecond: Double) ->Double
    {
        return metersPerSecond * 2.23694
    }
    
    func metersToYards(meters: Double) -> Double
    {
        return meters * 1.09361
    }
    
    func getDistance(locationOne: CLLocationCoordinate2D, locationTwo: CLLocationCoordinate2D) -> Double {
        let x = CLLocation(latitude: locationOne.latitude, longitude: locationOne.longitude)
        let y = CLLocation(latitude: locationTwo.latitude, longitude: locationTwo.longitude)
        
        let meters = x.distance(from: y)
        
        return metersToYards(meters: meters)
    }
    
    //    func getPoints(_ hole:Int){
    //        let holeNum = holes[hole]
    //        let teelocation = CLLocationCoordinate2D(latitude: holeNum.teeX, longitude: holeNum.teeY)
    //        let greenlocation = CLLocationCoordinate2D(latitude: holeNum.greenX, longitude: holeNum.greenY)
    //        var dist = getDistance(locationOne: teelocation, locationTwo: greenlocation)
    //        dist.round(.toNearestOrAwayFromZero)
    //        distanceLabel.text = "\(dist) Yards"
    //
    //        createHoleMap(teeLocation: teelocation, greenLocation: greenlocation)
    //    }
    func getPoints(_ hole:Int){
        let holeNum = holes[hole]
        let currLocation:CLLocationCoordinate2D = userLocation
        let teelocation = CLLocationCoordinate2D(latitude: holeNum.teeX, longitude: holeNum.teeY)
        let greenlocation = CLLocationCoordinate2D(latitude: holeNum.greenX, longitude: holeNum.greenY)
        //var dist = getDistance(locationOne: teelocation, locationTwo: greenlocation)
        var dist = getDistance(locationOne: currLocation, locationTwo: greenlocation)
        dist.round(.toNearestOrAwayFromZero)
        distanceLabel.text = "\(dist) Yards"
        let adjustedDistance = clubRecommendation(locationOneCoordinate: currLocation, locationTwoCoordinate: teelocation)
        createHoleMap(teeLocation: teelocation, greenLocation: greenlocation)
    }
    
    func degreesToRadians(degrees: Double) -> Double
    {
        return ((degrees * .pi) / 180.0)
    }
    
    func radiansToDegrees(radians: Double) -> Double
    {
        return ((radians * 180) / .pi)
    }
    
    func getDirectionBetweenToPoints(LocationOne: CLLocationCoordinate2D, LocationTwo: CLLocationCoordinate2D) -> Double
    {
        let lat1 = degreesToRadians(degrees: LocationOne.latitude)
        let lat2 = degreesToRadians(degrees: LocationTwo.latitude)
        
        let lon1 = degreesToRadians(degrees: LocationOne.longitude)
        let lon2 = degreesToRadians(degrees: LocationTwo.longitude)
        
        let dLon = lon2 - lon1
        
        let y = sin(dLon) * cos(lat2)
        let x = cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(dLon)
        let direction = atan2(y, x)
        
        return radiansToDegrees(radians: direction)
    }
    
    func getElevationChange(elevationOne: Double, elevationTwo: Double) -> Double
    {
        let elevationChange = elevationTwo - elevationOne
        return metersToYards(meters: elevationChange)
    }
    
    func accountForWind(shotDirection: Double, shotDistance: Double, windDirection: Double, windSpeed: Double) -> Double {
        let difDirection = shotDirection - windDirection
        var distanceChange: Double
        
        if(difDirection >= -15 && difDirection <= 15)
        {
            distanceChange = -1 * ((shotDistance * 0.005) * windSpeed)
        }
            
        else if(difDirection >= -195 && difDirection <= -165)
        {
            distanceChange = ((shotDistance * 0.01) * windSpeed)
        }
            
        else
        {
            distanceChange = 0;
        }
        
        return distanceChange
    }
    
    func clubRecommendation(locationOneCoordinate: CLLocationCoordinate2D, locationTwoCoordinate: CLLocationCoordinate2D)
        -> Double
    {
        let distance = getDistance(locationOne: locationOneCoordinate, locationTwo: locationTwoCoordinate)
        let direction = getDirectionBetweenToPoints(LocationOne: locationOneCoordinate, LocationTwo: locationTwoCoordinate)
        let windDistanceChange = accountForWind(shotDirection: direction, shotDistance: distance, windDirection: wind[0], windSpeed: wind[1])
        var adjustedDistance: Double
        
        adjustedDistance = distance + windDistanceChange
        
        return adjustedDistance
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
            destination.courseId = courseId
        }
    }
    
}


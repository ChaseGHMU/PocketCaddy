//
//  FlagAnnotation.swift
//  PocketCaddy
//
//  Created by Chase Allen on 3/12/18.
//  Copyright © 2018 Chase Allen. All rights reserved.
//

import UIKit
import MapKit

class FlagAnnotation: NSObject, MKAnnotation {
    var title: String?
    var imageName: String?
    var coordinate: CLLocationCoordinate2D
    var image: UIImage?
    
    init(coordinate: CLLocationCoordinate2D){
        self.coordinate = coordinate
    }
}

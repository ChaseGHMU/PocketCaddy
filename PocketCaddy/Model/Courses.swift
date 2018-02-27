//
//  Courses.swift
//  PocketCaddy
//
//  Created by Chase Allen on 2/27/18.
//  Copyright © 2018 Chase Allen. All rights reserved.
//

import Foundation

struct Course: Codable{
    let id: Int
    let name: String
    let address1: String
    let address2: String?
    let city: String
    let state: String
    let zipCode: Int
    
    private enum CodingKeys : String, CodingKey {
        case id = "courseId"
        case name = "courseName"
        case address1 = "addressLine1"
        case address2 = "addressLine2"
        case city
        case state
        case zipCode
    }
}

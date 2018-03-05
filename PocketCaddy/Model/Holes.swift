//
//  Holes.swift
//  PocketCaddy
//
//  Created by Chase Allen on 2/27/18.
//  Copyright © 2018 Chase Allen. All rights reserved.
//

import Foundation

struct Holes: Codable {
    
    let id: Int?
    let number: Int?
    let par: Int?
    
    private enum CodingKeys : String, CodingKey {
        case id = "courseID"
        case number
        case par
    }
}

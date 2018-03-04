//
//  Swings.swift
//  PocketCaddy
//
//  Created by Chase Allen on 3/3/18.
//  Copyright © 2018 Chase Allen. All rights reserved.
//

import Foundation

struct Swings: Codable {
    
    let swingId: String
    let distance: String
    let clubId: String
    
    private enum CodingKeys : String, CodingKey {
        case swingId
        case distance
        case clubId
    }
}

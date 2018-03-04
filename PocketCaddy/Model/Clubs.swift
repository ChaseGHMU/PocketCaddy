//
//  Clubs.swift
//  PocketCaddy
//
//  Created by Chase Allen on 3/3/18.
//  Copyright © 2018 Chase Allen. All rights reserved.
//

import Foundation

struct Clubs: Codable{
    
    let id: String
    let type: String
    let name: String
    let distance: String
    let userId: String
    
    private enum CodingKeys : String, CodingKey {
        case id = "clubId"
        case type
        case name = "nickname"
        case distance = "avgDistance"
        case userId
    }
}

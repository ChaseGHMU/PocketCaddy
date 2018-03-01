//
//  User.swift
//  PocketCaddy
//
//  Created by Chase Allen on 3/1/18.
//  Copyright © 2018 Chase Allen. All rights reserved.
//

import Foundation

struct User: Codable{
    let id: String
    let username: String
    let userId: Int
    
    private enum CodingKeys : String, CodingKey {
        case userId
        case id
        case username
    }
}

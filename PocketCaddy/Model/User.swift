//
//  User.swift
//  PocketCaddy
//
//  Created by Chase Allen on 3/1/18.
//  Copyright © 2018 Chase Allen. All rights reserved.
//

import Foundation

struct User: Codable{
    let email: String
    let id: Int
    let username: String
    
    private enum CodingKeys : String, CodingKey {
        case email
        case id
        case username
    }
}

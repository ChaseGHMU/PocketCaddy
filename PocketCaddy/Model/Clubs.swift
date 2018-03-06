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
        case name = "nickname" //NOT NULL
        case distance = "avgDistance"
        case userId //NOT NULL
    }
    
    /*
    EXAMPLE POST PARARMETERS FOR CLUBS
     
    http://ec2-54-145-167-39.compute-1.amazonaws.com:3000/api/Clubs
     
    let clubPost: Parameters = [
        "nickname": "insert_name_here",
        "userId": "insert_id_from_UserDefault_here"
    ]
    */
}

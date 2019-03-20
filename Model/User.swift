//
//  User.swift
//  MyFavoriteApp
//
//  Created by Colin Smith on 3/20/19.
//  Copyright © 2019 Colin Smith. All rights reserved.
//

import Foundation

struct User: Codable {
    
    let username: String
    let favoriteApp: String
    
    
    enum CodingKeys: String, CodingKey {
        case name
        case favoriteApp = "faveApp"
        
    }
    
    
}

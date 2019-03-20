//
//  User.swift
//  MyFavoriteApp
//
//  Created by Colin Smith on 3/20/19.
//  Copyright © 2019 Colin Smith. All rights reserved.
//

import Foundation

struct User: Codable {
    
    let user: String
    let favoriteApp: String
    
    
    enum CodingKeys: String, CodingKey {
        case user = "name"
        case favoriteApp = "faveApp"
    }
    
    
}

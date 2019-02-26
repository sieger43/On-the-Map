//
//  LoginRequest.swift
//  On the Map
//
//  Created by John Berndt on 2/12/19.
//  Copyright © 2019 John Berndt. All rights reserved.
//

struct LoginRequest: Codable {
    
    let udacity: [String:String]
    
    enum CodingKeys: String, CodingKey {
        case udacity
    }
}

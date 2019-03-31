//
//  StudentLocation.swift
//  On the Map
//
//  Created by John Berndt on 2/12/19.
//  Copyright © 2019 John Berndt. All rights reserved.
//

struct StudentInformation: Codable {
    
    let objectId : String
    let uniqueKey : String?
    let firstName : String?
    let lastName : String?
    let mapString : String?
    let mediaURL : String?
    let latitude : Double?
    let longitude : Double?
    let createdAt : String
    let updatedAt : String
    
    enum CodingKeys: String, CodingKey {
        
        case objectId
        case uniqueKey
        case firstName
        case lastName
        case mapString
        case mediaURL
        case latitude
        case longitude
        case createdAt
        case updatedAt
    }
}

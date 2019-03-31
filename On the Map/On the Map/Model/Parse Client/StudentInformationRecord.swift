//
//  StudentLocationRecord.swift
//  On the Map
//
//  Created by John Berndt on 2/24/19.
//  Copyright © 2019 John Berndt. All rights reserved.
//

struct StudentInformationRecord: Codable {
    
    let uniqueKey : String?
    let firstName : String?
    let lastName : String?
    let mapString : String?
    let mediaURL : String?
    let latitude : Double?
    let longitude : Double?
    
    enum CodingKeys: String, CodingKey {
        
        case uniqueKey
        case firstName
        case lastName
        case mapString
        case mediaURL
        case latitude
        case longitude
    }
}

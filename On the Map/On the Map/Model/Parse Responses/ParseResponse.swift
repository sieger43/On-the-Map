//
//  ParseResponse.swift
//  On the Map
//
//  Created by John Berndt on 2/24/19.
//  Copyright © 2019 John Berndt. All rights reserved.
//

import Foundation

struct ParseResponse: Codable {
    let statusCode: Int
    let statusMessage: String
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case statusMessage = "status_message"
    }
}

extension ParseResponse: LocalizedError {
    var errorDescription: String? {
        return statusMessage
    }
}

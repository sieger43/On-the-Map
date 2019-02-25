//
//  ParsePostResponse.swift
//  On the Map
//
//  Created by John Berndt on 2/24/19.
//  Copyright © 2019 John Berndt. All rights reserved.
//

import Foundation

struct ParsePostResponse: Codable {
    let createdAt: String
    let objectId: String
    let statusMessage: String?
}

extension ParsePostResponse: LocalizedError {
    var errorDescription: String? {
        return statusMessage
    }
}

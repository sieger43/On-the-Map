//
//  ParsePutResponse.swift
//  On the Map
//
//  Created by John Berndt on 4/18/19.
//  Copyright © 2019 John Berndt. All rights reserved.
//
import Foundation

struct ParsePutResponse: Codable {
    let updatedAt: String
    let statusMessage: String?
}

extension ParsePutResponse: LocalizedError {
    var errorDescription: String? {
        return statusMessage
    }
}

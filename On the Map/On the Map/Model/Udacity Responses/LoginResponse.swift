//
//  LoginResponse.swift
//  On the Map
//
//  Created by John Berndt on 2/25/19.
//  Copyright © 2019 John Berndt. All rights reserved.
//

import Foundation

struct LoginAccount : Codable {
    let registered : Bool
    let key: String
}

struct LoginSession : Codable {
    let id: String
    let expiration: String
}

struct LoginResponse: Codable {
    let account: LoginAccount
    let session: LoginSession
}

extension LoginResponse: LocalizedError {
    var errorDescription: String? {
        return ""
    }
}

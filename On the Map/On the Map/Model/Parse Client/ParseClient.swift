//
//  ParseClient.swift
//  On the Map
//
//  Created by John Berndt on 2/12/19.
//  Copyright © 2019 John Berndt. All rights reserved.
//

import Foundation

class ParseClient
{
    static let restApiKey = "QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY"
    static let restAppID = "QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr"

    struct Auth {
        static var accountId = 0
        static var requestToken = ""
        static var sessionId = ""
    }
    
    enum Endpoints {
        static let base = "https://parse.udacity.com/parse/classes"
    }
}

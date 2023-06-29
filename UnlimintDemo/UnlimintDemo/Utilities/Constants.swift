//
//  Constants.swift
//  UnlimintDemo
//
//  Created by Romesh Bansal on 29/06/23.
//

import Foundation

struct Constant {
    static let jokeFetchDuration = 60.0
    static let maximumJokeCount = 10
    static let dataStoringKey = "JOKES"
}

struct APIEndpoints {
    
    static func getJokesURLPath() -> String {
        return "https://geek-jokes.sameerkumar.website/api?format=json"
    }
}

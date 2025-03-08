//
//  Match.swift
//  MatchMate
//
//  Created by Aakash Narkar on 08/03/25.
//

import Foundation

struct Match: Identifiable, Codable, Equatable {
    var id = UUID()
    let name: String
    let age: Int
    let imageUrl: String
    var status: String?

    init(from user: User) {
        self.name = "\(user.name.first) \(user.name.last)"
        self.age = user.dob.age
        self.imageUrl = user.picture.large
    }

    static func == (lhs: Match, rhs: Match) -> Bool {
        return lhs.id == rhs.id
    }
}

struct APIResponse: Codable {
    let results: [User]
}

struct User: Codable {
    let name: Name
    let dob: DOB
    let picture: Picture
}

struct Name: Codable {
    let first: String
    let last: String
}

struct DOB: Codable {
    let age: Int
}

struct Picture: Codable {
    let large: String
}

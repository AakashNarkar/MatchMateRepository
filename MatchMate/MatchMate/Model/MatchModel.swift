//
//  Match.swift
//  MatchMate
//
//  Created by Aakash Narkar on 08/03/25.
//

import Foundation

struct APIResponse: Codable {
    var results: [Result]?
    var info: Info?
}

struct Info: Codable {
    var seed: String?
    var results, page: Int?
    var version: String?
}

struct Result: Codable {
    var gender: Gender?
    var name: Name?
    var location: Location?
    var email: String?
    var login: Login?
    var dob, registered: Dob?
    var phone, cell: String?
    var id: ID?
    var picture: Picture?
    var nat: String?
}

struct Dob: Codable {
    var date: String?
    var age: Int?
}

enum Gender: String, Codable {
    case female = "female"
    case male = "male"
}

struct ID: Codable {
    var name: String?
    var value: String?
}

struct Location: Codable {
    var street: Street?
    var city, state, country: String?
    var postcode: Postcode?
    var coordinates: Coordinates?
    var timezone: Timezone?
}

struct Coordinates: Codable {
    var latitude, longitude: String?
}

enum Postcode: Codable {
    case integer(Int)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(Postcode.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Postcode"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}

struct Street: Codable {
    var number: Int?
    var name: String?
}

struct Timezone: Codable {
    var offset, description: String?
}

struct Login: Codable {
    var uuid, username, password, salt: String?
    var md5, sha1, sha256: String?
}

struct Name: Codable {
    var title, first, last: String?
}

struct Picture: Codable {
    var large, medium, thumbnail: String?
}

struct Match: Codable, Equatable {
    var identifier = UUID()
    var value: String?
    var fullName, address, image: String?
    var isAccepted: Bool?
    var imageData: Data?
    
    static func == (lhs: Match, rhs: Match) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}

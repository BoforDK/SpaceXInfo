//
//  Launch.swift
//  SpaceXInfo
//
//  Created by Alexander Grigorov on 19.05.2022.
//

import Foundation

struct Launch: Codable {
    var fairings: Fairing?
    var links: Links
    var staticFireDateUtc: String?
    var staticFireDateUnix: Int?
    var net: Bool
    var window: Int?
    var rocket: String?
    var success: Bool?
    var failures: [Failure]
    var crew: [String]
    var ships: [String]
    var capsules: [String]
    var payloads: [String]
    var launchpad: String
    var flightNumber: Int
    var name: String
    var dateUtc: String
    var dateUnix: Int
    var dateLocal: String
    var datePrecision: String
    var upcoming: Bool
    var cores: [Core]
    var autoUpdate: Bool
    var tbd: Bool
    var launchLibraryId: UUID?
    var id: String?
}

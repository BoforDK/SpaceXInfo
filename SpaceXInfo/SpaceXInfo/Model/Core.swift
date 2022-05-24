//
//  Core.swift
//  SpaceXInfo
//
//  Created by Alexander Grigorov on 19.05.2022.
//

import Foundation

struct Core: Codable {
    var core: String?
    var flight: Int?
    var gridfins: Bool?
    var legs: Bool?
    var reused: Bool?
    var landingAttempt: Bool?
    var landingSuccess: Bool?
    var landingType: String?
    var landpad: String?
}

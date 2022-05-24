//
//  Fairing.swift
//  SpaceXInfo
//
//  Created by Alexander Grigorov on 19.05.2022.
//

import Foundation

struct Fairing: Codable {
    var reused: Bool?
    var recoveryAttempt: Bool?
    var recovered: Bool?
    var ships: [String]
}

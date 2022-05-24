//
//  Failure.swift
//  SpaceXInfo
//
//  Created by Alexander Grigorov on 19.05.2022.
//

import Foundation

struct Failure: Codable {
    var time: Int
    var altitude: Int?
    var reason: String
}

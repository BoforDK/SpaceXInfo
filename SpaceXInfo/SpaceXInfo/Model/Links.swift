//
//  Links.swift
//  SpaceXInfo
//
//  Created by Alexander Grigorov on 19.05.2022.
//

import Foundation

struct Links: Codable {
    var patch: Patch
    var reddit: Reddit
    var flickr: Flickr
    var presskit: String?
    var webcast: String?
    var youtube_id: UUID?
    var article: String?
    var wikipedia: String?
}

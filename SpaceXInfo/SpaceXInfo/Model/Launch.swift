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
    var staticFireDateUtc: Date?
    var staticFireDateUnix: Date?
    var net: Bool
    var window: Int?
    var rocket: String?
    var success: Bool?
    var failures: [Failure]
    var crewIds: [String]
    var shipIds: [String]
    var capsuleIds: [String]
    var payloadIds: [String]
    var launchpadId: String
    var flightNumber: Int
    var name: String
    var dateUtc: Date
    var dateUnix: Date
    var dateLocal: Date
    var datePrecision: DatePrecision
    var upcoming: Bool
    var cores: [Core]
    var autoUpdate: Bool
    var tbd: Bool
    var launchLibraryId: UUID?
    var id: String?
}

extension Launch {
    enum CodingKeys: String, CodingKey {
        case fairings
        case links
        case staticFireDateUtc
        case staticFireDateUnix
        case net
        case window
        case rocket
        case success
        case failures
        case crewIds = "crew"
        case shipIds = "ships"
        case capsuleIds = "capsules"
        case payloadIds = "payloads"
        case launchpadId = "launchpad"
        case flightNumber
        case name
        case dateUtc
        case dateUnix
        case dateLocal
        case datePrecision
        case upcoming
        case cores
        case autoUpdate
        case tbd
        case launchLibraryId
        case id
    }
    
    enum DatePrecision: String, Codable {
        case hour
        case day
        case month
        case quarter
    }
}

extension Launch {
    private static let localUTCDateFormatter = StringToDateFormatter(dateFormat: .localUTC)
    private static let UTCDateFormatter = StringToDateFormatter(dateFormat: .utc)
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.fairings = try container.decode(Fairing?.self, forKey: .fairings)
        self.links = try container.decode(Links.self, forKey: .links)
        self.net = try container.decode(Bool.self, forKey: .net)
        self.window = try container.decode(Int?.self, forKey: .window)
        self.rocket = try container.decode(String?.self, forKey: .rocket)
        self.success = try container.decode(Bool?.self, forKey: .success)
        self.failures = try container.decode([Failure].self, forKey: .failures)
        self.crewIds = try container.decode([String].self, forKey: .crewIds)
        self.shipIds = try container.decode([String].self, forKey: .shipIds)
        self.capsuleIds = try container.decode([String].self, forKey: .capsuleIds)
        self.payloadIds = try container.decode([String].self, forKey: .payloadIds)
        self.launchpadId = try container.decode(String.self, forKey: .launchpadId)
        self.flightNumber = try container.decode(Int.self, forKey: .flightNumber)
        self.name = try container.decode(String.self, forKey: .name) //String
        self.datePrecision = try container.decode(DatePrecision.self, forKey: .datePrecision)
        self.upcoming = try container.decode(Bool.self, forKey: .upcoming)
        self.cores = try container.decode([Core].self, forKey: .cores)
        self.autoUpdate = try container.decode(Bool.self, forKey: .autoUpdate)
        self.tbd = try container.decode(Bool.self, forKey: .tbd)
        self.launchLibraryId = try container.decode(UUID?.self, forKey: .launchLibraryId)
        self.id = try container.decode(String?.self, forKey: .id)
        
        let intDateUnix = try container.decode(Int.self, forKey: .dateUnix)
        self.dateUnix = Date(timeIntervalSince1970: TimeInterval(intDateUnix))
        
        if let intStaticFireDateUnix = try container.decode(Int?.self, forKey: .staticFireDateUnix) {
            self.staticFireDateUnix =  Date(timeIntervalSince1970: TimeInterval(intStaticFireDateUnix))
        }
        
        // Decode variables with error handling
        let stringDateUTC = try container.decode(String.self, forKey: .dateUtc)
        if let dateUtc =  Launch.UTCDateFormatter.date(from: stringDateUTC) {
            self.dateUtc =  dateUtc
        } else {
            let codingPath = [CodingKeys.dateUtc]
            let debugDescription = "Expected to decode Date of \(Launch.UTCDateFormatter.dateFormat.rawValue) format but found an another format instead."
            throw DecodingError.typeMismatch(Date.self, .init(codingPath: codingPath,
                                                              debugDescription: debugDescription))
        }
        
        let stringDateLocal = try container.decode(String.self, forKey: .dateLocal)
        if let dateLocal = Launch.localUTCDateFormatter.date(from: stringDateLocal) {
            self.dateLocal = dateLocal
        } else {
            let codingPath = [CodingKeys.dateLocal]
            let debugDescription = "Expected to decode Date of \(Launch.localUTCDateFormatter.dateFormat.rawValue) format but found an another format instead."
            throw DecodingError.typeMismatch(Date.self, .init(codingPath: codingPath,
                                                              debugDescription: debugDescription))
        }
        
        if let stringStaticFireDateUtc = try container.decode(String?.self, forKey: .staticFireDateUtc) {
            self.staticFireDateUtc = Launch.UTCDateFormatter.date(from: stringStaticFireDateUtc)
            if self.staticFireDateUtc == nil {
                let codingPath = [CodingKeys.staticFireDateUtc]
                let debugDescription = "Expected to decode Date of \(Launch.UTCDateFormatter.dateFormat.rawValue) format but found a another format instead."
                throw DecodingError.typeMismatch(Date.self, .init(codingPath: codingPath,
                                                                  debugDescription: debugDescription))
            }
        }
    }
}

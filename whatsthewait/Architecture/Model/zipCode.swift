//
//  zipCode.swift
//  whatsthewait
//
//  Created by Harsh Rajput on 18/07/20.
//  Copyright © 2020 Harsh Rajput. All rights reserved.
//

import Foundation
import Foundation

// MARK: - WelcomeElement
struct ZipCode  : Codable {
    let found: String
    let record: [Record]
}
 
// MARK: - Record
struct Record: Codable {
    let zipCode, latitude, longitude, county: String
    let city, state, stateFull: String

    enum CodingKeys: String, CodingKey {
        case zipCode = "ZipCode"
        case latitude = "Latitude"
        case longitude = "Longitude"
        case county = "County"
        case city = "City"
        case state = "State"
        case stateFull = "StateFull"
    }
}

typealias ZipCodedata = [ZipCode]

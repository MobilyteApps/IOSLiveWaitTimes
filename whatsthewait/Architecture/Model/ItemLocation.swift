//
//  ItemLocation.swift
//  whatsthewait
//
//  Created by Harsh Rajput on 14/07/20.
//  Copyright © 2020 Harsh Rajput. All rights reserved.
//

import Foundation

// MARK: - Welcome
struct ItemLocation: Codable {
    let locationName: String
    let rideLink: String
    let rideText, phone, callText: String
    let directionsLink: String
    let directionsText: String
}

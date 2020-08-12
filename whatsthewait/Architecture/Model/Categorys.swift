//
//  Categorys.swift
//  whatsthewait
//
//  Created by Harsh Rajput on 18/07/20.
//  Copyright © 2020 Harsh Rajput. All rights reserved.
//

import Foundation

struct Categorys: Codable {
    let id, name, icon, iconURL,iconURLDisabled ,isEnabled: String

    enum CodingKeys: String, CodingKey {
        case id
        case name = "Name"
        case icon = "Icon"
        case isEnabled = "IsEnabled"
        case iconURL = "IconURL"
        case iconURLDisabled = "IconURLDisabled"
    }
}

typealias CategorysList = [Categorys]

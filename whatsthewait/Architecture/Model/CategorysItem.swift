//
//  CategorysItem.swift
//  whatsthewait
//
//  Created by Harsh Rajput on 13/07/20.
//  Copyright © 2020 Harsh Rajput. All rights reserved.
//

import Foundation


// MARK: - WelcomeElement
struct CategorysItem: Codable {
    let companyName, category, waitSource, locationName: String
    let locationID, address, city, state: String
    let zip, latitude, longitude, phoneDisplay: String
    let phoneNumeric, waitTimeLow, waitTimeHigh, waitTimeAverage: String
    let waitTimeDisplay, distance: String
    let joinURL: String
    let joinText,isFeatured, clinicID: String

    
}
//var Dtime:DriveTime()? = {
//    let params:[String:Any] = [:]
//           print("====>\(params)")
//           ApiManager.shared.get(url: ApiUrls.categoryItems, params: params) { (res:DriveTime?, err) in
//
//               if let error = err {
//                   return  nil
//
//               } else {
//                   guard let resp = res else {return }
//                   drivetime = resp
//               }
//
//
//       }
//
//}

typealias CatItems = [CategorysItem]

//
//  AppDelegate.swift
//  whatsthewait
//
//  Created by Harsh Rajput on 09/07/20.
//  Copyright © 2020 Harsh Rajput. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    lazy var window: UIWindow? = {
        return UIApplication.shared.windows.first
    }()


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        IQKeyboardManager.shared.enable = true
        return true
    }

  


}


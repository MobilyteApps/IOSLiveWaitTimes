//
//  UIViewController.swift
//  whatsthewait
//
//  Created by Harsh Rajput on 20/07/20.
//  Copyright © 2020 Harsh Rajput. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func popupAlert(title: String?, message: String?, style:UIAlertController.Style = .alert, actionTitles:[String?], actions:[((UIAlertAction) -> Void)?]) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        for (index, title) in actionTitles.enumerated() {
            let action = UIAlertAction(title: title, style: .default, handler: actions[index])
            alert.addAction(action)
        }
        self.present(alert, animated: true, completion: nil)
    }
}


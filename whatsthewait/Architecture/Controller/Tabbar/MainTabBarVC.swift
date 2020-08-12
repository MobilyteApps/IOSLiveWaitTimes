//
//  MainTabBarVC.swift
//  whatsthewait
//
//  Created by Harsh Rajput on 09/07/20.
//  Copyright © 2020 Harsh Rajput. All rights reserved.
//

import UIKit
import SWRevealViewController
class MainTabBarVC: UITabBarController {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    override func viewDidLoad() {
        if self.revealViewController() != nil {

            menuButton.target = self.revealViewController()
            
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
            tabBar.barTintColor = AppColors.primeryColorYellow
            tabBar.tintColor = .lightGray
            tabBar.unselectedItemTintColor = .black
            tabBar.isTranslucent = false

        }
        tabBar.barTintColor = AppColors.primeryColorYellow
        tabBar.tintColor = .lightGray
        tabBar.unselectedItemTintColor = .black
        tabBar.isTranslucent = false
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
 ??   }
    */
   
    
}

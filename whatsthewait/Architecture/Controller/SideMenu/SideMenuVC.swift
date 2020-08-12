//
//  SideMenuVC.swift
//  whatsthewait
//
//  Created by Harsh Rajput on 09/07/20.
//  Copyright © 2020 Harsh Rajput. All rights reserved.
//

import UIKit

class SideMenuVC: UIViewController {
    @IBOutlet weak var tblMenu: UITableView!

    var itemImages = [#imageLiteral(resourceName: "home-run"),#imageLiteral(resourceName: "restaurants"),#imageLiteral(resourceName: "salons"),#imageLiteral(resourceName: "clinics"),#imageLiteral(resourceName: "hospitals")]
    var itemName = ["Home","Restaurants","Salons/Barbers","Clinics","Hospitals/ERs"]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation
     
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension SideMenuVC:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemImages.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell")as! MenuCell
        cell.imgItem.image = itemImages[indexPath.row]
        cell.lblItem.text = itemName[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}



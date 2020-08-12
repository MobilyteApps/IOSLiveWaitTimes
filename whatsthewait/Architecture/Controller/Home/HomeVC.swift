//
//  HomeVC.swift
//  whatsthewait
//
//  Created by Harsh Rajput on 09/07/20.
//  Copyright © 2020 Harsh Rajput. All rights reserved.
//

import UIKit
import SWRevealViewController
class HomeVC: BaseVC {
    @IBOutlet weak var btnMenu: UIButton!
    @IBOutlet weak var viewLocation: UIView!
    @IBOutlet weak var btnGo: UIButton!
    @IBOutlet weak var txtPin: UITextField!
    @IBOutlet weak var tblcatlist: UITableView!

   
   
    var categorydatalist : CategorysList? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer());
        presetView()
        
    }
    
    private func presetView(){
        btnMenu.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        NotificationCenter.default.addObserver(self, selector: #selector(self.userLocationUpdate(notification:)), name: Notification.Name("locationManagerUpdate"), object: nil)
        if locationLongitude == nil{
            locationRequst()
        }else{
            print(" **locationLongitude** \(locationLongitude)")
            print(" **locationLatitude**  \(locationLatitude)")
            viewLocation.isHidden = true
        }
    }
    
    @objc func userLocationUpdate(notification: Notification) {
        print(" **userLocationUpdate**locationLongitude \(locationLongitude)")
        print(" **userLocationUpdate**locationLatitude  \(locationLatitude)")
        viewLocation.isHidden = true
        getCategorys()
    }
    
    @IBAction func goWithPinCode(sender:UIButton) -> Void{
        if let zip = self.txtPin.text , zip.count > 4 {
            getZipLocation(with: zip)
        }else{
            print("ZipCode not valide")
        }
          
    }
    @IBAction func selcteLocationVC(sender:UIButton) -> Void{
        openLocationVC()
    }
    
    func getCategorys(){
        
        ApiManager.shared.get(url: ApiUrls.categoryListUrl, params: nil) { (res:CategorysList?, err) in
            
            if let error = err {
                print("error in categoryItems api :\(error)")
                self.categorydatalist = nil
                
            } else {
                guard let resp = res else {return}
                self.categorydatalist = resp
                self.tblcatlist.reloadData()
                print("resp in create user api : \(resp)")
            }
        }
    }

}
extension HomeVC:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categorydatalist?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell")as! HomeCell
        cell.catItem = categorydatalist![indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let categoryItem = categorydatalist![indexPath.row]
        let VC = storyboard?.instantiateViewController(identifier: "SelectedCatVC")as! SelectedCatVC
        VC.catID = categoryItem.id
        VC.catImageUrl = categoryItem.iconURL
        self.navigationController?.pushViewController(VC, animated: true)
    }
}

extension HomeVC:UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.text?.count ??  0<4{
            self.btnGo.backgroundColor = UIColor.white
        }else{
            self.btnGo.backgroundColor = UIColor.systemGreen
        }
        return true;
    }
}

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
        let params:[String:Any] = ["lon":locationLongitude ?? 0.0,"lat":locationLatitude ?? 0.0]
        ApiManager.shared.get(url: ApiUrls.categoryListUrl, params: params) { (res:CategorysList?, err) in
            
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
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = categorydatalist?.count ?? 0
        return  count+1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell")as! HomeCell
        let count = categorydatalist?.count ?? 0
        if count != indexPath.row{
        cell.catItem = categorydatalist![indexPath.row]
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let count = categorydatalist?.count ?? 0
        if count != indexPath.row{
            
            let categoryItem = categorydatalist![indexPath.row]
            let VC = storyboard?.instantiateViewController(identifier: "SelectedCatVC")as! SelectedCatVC
            VC.catID = categoryItem.id
            VC.catImageUrl = categoryItem.iconURL
            self.navigationController?.pushViewController(VC, animated: true)
        }else{
            let VC = storyboard?.instantiateViewController(identifier: "ContactUsVC")as! ContactUsVC
            self.navigationController?.pushViewController(VC, animated: true)
        }
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

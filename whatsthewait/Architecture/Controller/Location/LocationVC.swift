//
//  LocationVC.swift
//  whatsthewait
//
//  Created by Harsh Rajput on 10/07/20.
//  Copyright © 2020 Harsh Rajput. All rights reserved.
//

import UIKit
import SWRevealViewController
class LocationVC: BaseVC {
    @IBOutlet weak var btnMenu: UIButton!
    @IBOutlet weak var btnGo: UIButton!
    @IBOutlet weak var txtPin: UITextField!

    

    override func viewDidLoad() {
        super.viewDidLoad()
        presetView()
        // Do any additional setup after loading the view.

    }
    
    private func presetView(){
        btnMenu.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        NotificationCenter.default.addObserver(self, selector: #selector(self.userLocationUpdate(notification:)), name: Notification.Name("locationManagerUpdate"), object: nil)
    }
    
    @objc func userLocationUpdate(notification: Notification) {
        print("**userLocationUpdate** \(locationManager.location!.coordinate)")
        print("**userLocationUpdate** LOCATIONVC")
    }
    

    @IBAction func goWithPinCode(sender: UIButton) -> Void{
        if let zip = self.txtPin.text , zip.count > 4 {
            getZipLocation(with: zip)
            self.dismiss(animated: true, completion: nil)
        }else{
            print("ZipCode invalide")
            self.popupAlert(title: "livewateTiems", message: "ZipCode invalide", actionTitles:[ "retry"], actions: [{action in
                    self.txtPin.becomeFirstResponder()
                }])
        }
    }
    @IBAction func getCurrentLocation(sender: UIButton) -> Void{
        isLocationServiceEnabel()
            //locationRequst()
    }
   @IBAction func clossVC(sender: UIButton) -> Void{
         self.dismiss(animated: true, completion: nil)
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

extension LocationVC:UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.text?.count ??  0<4{
            self.btnGo.backgroundColor = UIColor.lightGray
        }else{
            self.btnGo.backgroundColor = UIColor.systemGreen

        }
        return true;
    }
    
}

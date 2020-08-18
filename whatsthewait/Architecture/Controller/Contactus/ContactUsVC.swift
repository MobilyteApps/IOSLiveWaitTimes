//
//  ContactUsVC.swift
//  whatsthewait
//
//  Created by Harsh Rajput on 10/07/20.
//  Copyright © 2020 Harsh Rajput. All rights reserved.
//

import UIKit
import SWRevealViewController
import MessageUI
class ContactUsVC: BaseVC {
    @IBOutlet weak var btnMenu: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        btnMenu.addTarget(self, action: #selector(back), for: .touchUpInside)
//        btnMenu.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        // Do any additional setup after loading the view.
    }
    @IBAction func selcteLocationVC(sender:UIButton) -> Void{
        openLocationVC()
    }
    @objc func back(){
        navigationController?.popViewController(animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func contectEmail(sender: UIButton) -> Void{
        let mailComposeViewController = configureMailComposer()
        if MFMailComposeViewController.canSendMail(){
            self.present(mailComposeViewController, animated: true, completion: nil)
        }else{
            
            print("Can't send email")
        }
       }
    @IBAction func phoneCall(sender: UIButton) -> Void{
        call()
    }
    private func call(phoneNumber:String = "8137012000") {
          let cleanPhoneNumber = phoneNumber.components(separatedBy: CharacterSet.decimalDigits.inverted).joined(separator: "")
          let urlString:String = "tel://\(cleanPhoneNumber)"
          if let phoneCallURL = URL(string: urlString) {
              if (UIApplication.shared.canOpenURL(phoneCallURL)) {
                  UIApplication.shared.open(phoneCallURL, options: [:], completionHandler: nil)
              }
          }
    }
    

}
extension ContactUsVC:MFMailComposeViewControllerDelegate{
   
    
    func configureMailComposer() -> MFMailComposeViewController{
        let mailComposeVC = MFMailComposeViewController()
        mailComposeVC.mailComposeDelegate = self
        mailComposeVC.setToRecipients(["contact@livewaittimes.com"])
        //mailComposeVC.setSubject(self.textFieldSubject.text!)
        //mailComposeVC.setMessageBody(self.textViewBody.text!, isHTML: false)
        return mailComposeVC
    }

    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}

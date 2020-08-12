//
//  JoinListVC.swift
//  whatsthewait
//
//  Created by Harsh Rajput on 17/07/20.
//  Copyright © 2020 Harsh Rajput. All rights reserved.
//

 
 import UIKit
 import WebKit
 class JoinListVC: UIViewController,WKNavigationDelegate {
    @IBOutlet weak var wView: UIView!
    var joinUrl:String?=nil
    var webView: WKWebView!
   override func viewDidLoad() {
      super.viewDidLoad()
        DispatchQueue.main.async {
            let url = NSURL(string: self.joinUrl ?? "")
            let request = NSURLRequest(url: url! as URL)
            // init and load request in webview.
            self.webView = WKWebView(frame: self.view.frame)
            self.webView.navigationDelegate = self
            self.webView.load(request as URLRequest)
            self.wView.addSubview(self.webView)
            self.wView.sendSubviewToBack(self.webView)
    }
   }
  //MARK:- WKNavigationDelegate

    private func webView(webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: NSError) {
        print(error.localizedDescription)
    }


    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("Strat to load")
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("finish to load")
    }
    @IBAction func clossVC(sender: UIButton) -> Void{
        self.dismiss(animated: true, completion: nil)
    }
}

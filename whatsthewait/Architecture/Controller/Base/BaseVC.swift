//
//  BaseVC.swift
//  whatsthewait
//
//  Created by Harsh Rajput on 10/07/20.
//  Copyright © 2020 Harsh Rajput. All rights reserved.
//

var locationLatitude : Double? = nil
var locationLongitude : Double? = nil
var isNetworkAvlable : Bool? = false

import UIKit
import CoreLocation
class BaseVC: UIViewController {
    let locationManager = CLLocationManager()


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

}


extension BaseVC:CLLocationManagerDelegate{
    
    func locationRequst(){
        self.locationManager.requestAlwaysAuthorization()

        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        locationLatitude = locValue.latitude
        locationLongitude = locValue.longitude
        manager.stopUpdatingLocation()
        NotificationCenter.default.post(name: Notification.Name("locationManagerUpdate"), object: nil)

    }
    func isLocationServiceEnabel(){
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .notDetermined, .restricted, .denied:
                print("No access")
                if let bundleId = Bundle.main.bundleIdentifier,
                    let url = URL(string: "\(UIApplication.openSettingsURLString)&path=LOCATION/\(bundleId)")
                {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
                self.dismiss(animated: true, completion: nil)
            case .authorizedAlways, .authorizedWhenInUse:
                print("Access")
                locationRequst()
                self.dismiss(animated: true, completion: nil)
                
            @unknown default:
                break
            }
        } else {
            print("Location services are not enabled")
        }
    }
    
    }
    //MARK: other Function
extension BaseVC{

      func openJoinlintVC(url : String){
          let vc = storyboard?.instantiateViewController(identifier: "JoinListVC")as! JoinListVC
          vc.joinUrl  = url
          self.present(vc, animated: true, completion: nil)
      }
      func openLocationVC(){
          let vc = storyboard?.instantiateViewController(identifier: "LocationVC")as! LocationVC
          self.present(vc, animated: true, completion: nil)
      }
    func getZipLocation(with pin:String){
          self.view.endEditing(true)

         // https://livewaittimes.com/zipcodelatlon.php?zip=33624
          let parame = ["zip":pin]
                ApiManager.shared.get(url: ApiUrls.ZipUrl, params: parame) { (res:ZipCodedata?, err) in

                    if let error = err {
                        print("error in Zip api :\(error)")
                        locationLongitude = nil
                        locationLatitude = nil
                        let topVC = UIApplication.getTopViewController()
                        topVC!.popupAlert(title: "Livewaittimes", message: "Enter Zip code is invalid", actionTitles: ["ok"], actions: [nil])
                        
                    } else {
                        guard let resp = res?.first else {return}
                        if resp.found == "true"{
                          let lat = Double(resp.record.first!.latitude) ?? nil
                          let lon = Double(resp.record.first!.longitude) ?? nil
                        locationLongitude = lon
                        locationLatitude = lat
                        NotificationCenter.default.post(name: Notification.Name("locationManagerUpdate"), object: nil)

                }
            }
        }
    }
}
    


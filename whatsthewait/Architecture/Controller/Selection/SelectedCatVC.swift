//
//  SelectedCatVC.swift
//  whatsthewait
//
//  Created by Harsh Rajput on 11/07/20.
//  Copyright © 2020 Harsh Rajput. All rights reserved.
//

import UIKit
class SelectedCatVC: BaseVC {
    @IBOutlet weak var categoryTbl:UITableView!
    var showSections = Set<Int>()
    var catID : String? = nil
    var catImageUrl : String? = nil
    var catItems : CatItems? = nil
    var itemLocation : ItemLocation? = nil
    var refreshControl: UIRefreshControl!
    var filterby:sortBy = .distance

    enum sortBy {
        case distance
        case waitTime
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addRefrashcontroller()
        let nib = UINib(nibName: "CategorysHeaderCell", bundle: nil)
        categoryTbl.register(nib, forHeaderFooterViewReuseIdentifier: "CategorysHeaderCell")
        categoryTbl.register(UINib(nibName: "CategoryCell", bundle: nil), forCellReuseIdentifier: "CategoryCell")
        print("CATID=>\(catID)")
        getCategoryItems()
        
         NotificationCenter.default.addObserver(self, selector: #selector(self.userLocationUpdate(notification:)), name: Notification.Name("locationManagerUpdate"), object: nil)
        // Do any additional setup after loading the view.
    }
    func addRefrashcontroller(){
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "refresh")
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        categoryTbl.addSubview(refreshControl)
    }
    @objc func refresh(_ sender: Any) {
        //  your code to reload tableView
        getCategoryItems()
        self.refreshControl.endRefreshing()

    }
    deinit {
        print("Remove NotificationCenter Deinit")
        NotificationCenter.default.removeObserver(self)
    }
    
    func getCategoryItems(){
       self.catItems = nil
        categoryTbl.reloadData() //http://whatsthewait.ca/api/?catID=1&limit=25&lon=-82.0622434&sort=distance&lat=28.751471199999997&key=Cl3t7dvwQlu2w4kZq68fRM3NgGQM8j
        //https://livewaittimes.com/api/?lat=28.751471199999997&lon=-82.0622434&sort&catID='1'&sort=distance&key=Cl3t7dvwQlu2w4kZq68fRM3NgGQM8j&limit=25
        
        let params:[String:Any] = ["catID": catID!,"limit": 25,"lon":locationLongitude ?? 0.0 ,"sort":"distance","lat":locationLatitude ?? 0.0 ,"key":"Cl3t7dvwQlu2w4kZq68fRM3NgGQM8j"]
        print("====>\(params)")
        ApiManager.shared.get(url: ApiUrls.categoryItems, params: params) { (res:CatItems?, err) in
            
            if let error = err {
                print("error in categoryItems api :\(error)")
                self.catItems = nil
                self.categoryTbl.setEmptyMessage("No locations found")
                self.categoryTbl.reloadData()
            } else {
                guard let resp = res else {return}
                self.catItems = resp
                self.filter(sortBy: self.filterby)
                print("resp in create user api : \(resp)")
            }
        }
    }
    
    @IBAction func sortBy(sender:UIButton)-> Void{
        popupAlert(title: "Live Wait Times", message: "Sort by",style: .actionSheet, actionTitles: ["Distance","Wait Time"], actions: [{(action) in
                print("action 1")
                sender.setTitle("Distance", for: .normal)
                self.filter(sortBy: .distance)
            self.filterby = .distance
            },{(action) in
                print("Action 2")
                sender.setTitle("Wait Time", for: .normal)
                self.filter(sortBy: .waitTime)
                self.filterby = .waitTime
            }])
    }
    func filter(sortBy filter:sortBy = .distance){
        switch filter {
        case .distance:
            if catItems?.count ?? 0 > 1{
                self.catItems = catItems?.sorted {
                    Float($0.distance) ?? 0.0 < Float($1.distance) ?? 0.0
                }
               
                
            }
        case .waitTime:
            if catItems?.count ?? 0 > 1{
                self.catItems = catItems?.sorted {
                    Float($0.waitTimeAverage) ?? 0 < Float($1.waitTimeAverage) ?? 0
                }
            }
            
        }
        if self.catItems?.count ?? 0 == 0 {
            self.categoryTbl.setEmptyMessage("No locations found")
        }else{
            self.catItems = catItems?.sorted {
                Float($0.isFeatured) ?? 0 > Float($1.isFeatured) ?? 0
            }
            self.categoryTbl.restore()
        }
        self.categoryTbl.reloadData()
        
    }
    
    @IBAction func back(sender:UIButton) -> Void{
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func goJoinLink(sender:UIButton) -> Void{
        openJoinlintVC(url: catItems![sender.tag].joinURL)
    }
    
    @IBAction func selcteLocationVC(sender:UIButton) -> Void{
           openLocationVC()
       }
    @objc func userLocationUpdate(notification: Notification) {
           print("**userLocationUpdate**locationLongitude \(locationLongitude)")
            print("**userLocationUpdate**locationLatitude \(locationLatitude)")
          // viewLocation.isHidden = true
        
        DispatchQueue.main.asyncAfter(deadline: .now()+1, execute: {
            self.getCategoryItems()

        })

       }
}
extension SelectedCatVC:UITableViewDataSource,UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
//        if self.catItems?.count ?? 0 == 0 {
//            self.categoryTbl.setEmptyMessage("No recode found")
//        } else {
//            self.categoryTbl.restore()
//        }
        
        return self.catItems?.count ?? 0
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let  headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "CategorysHeaderCell")as! CategorysHeaderCell
        
        headerView.btnCheckIn.tag = section
        
        headerView.btnCheckIn.addTarget(self,
                                        action: #selector(self.goJoinLink(sender:)),
                                        for: .touchUpInside)
        guard let item = self.catItems?[section]else{return headerView}
        headerView.item = item
        
      
        headerView.catImg.sd_setImage(with: URL(string: catImageUrl!))
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        tapRecognizer.numberOfTapsRequired = 1
        tapRecognizer.numberOfTouchesRequired = 1
        headerView.tapView.addGestureRecognizer(tapRecognizer)
        tapRecognizer.view?.tag = section
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.showSections.contains(section) {
            return 1
        }
        
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell")as! CategoryCell
        cell.btnPhone.tag = indexPath.section
        cell.btnPhone.addTarget(self, action: #selector(call(sender:)) , for: .touchUpInside)
        cell.btnDirection.tag = indexPath.section
        cell.btnDirection.addTarget(self, action: #selector(openAppleDirectionMap(sender:)) , for: .touchUpInside)
        cell.btnDirectionMap.tag = indexPath.section
        cell.btnDirectionMap.addTarget(self, action: #selector(openAppleDirectionMap(sender:)) , for: .touchUpInside)
        cell.btnUber.tag = indexPath.section
        cell.btnUber.addTarget(self, action: #selector(openUberRide(sender:)) , for: .touchUpInside)
        
        cell.item = catItems![indexPath.section]
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
        
    }
    

    func tableView(_ tableView: UITableView, didEndDisplayingHeaderView view: UIView, forSection section: Int) {
        if self.showSections.contains(section){
            print(">>>>>>>>> INCLUDE \(section)")
            let preSection = self.showSections.first
            self.showSections.remove(preSection!)
            
            
            self.categoryTbl.deleteRows(at: [IndexPath(row: 0, section: section)],with: .fade)



        }else{
            print(">>>>>>>>>NOT INCLUDE \(section)")
        }
    }
    
   
    
   
    
    @objc func handleTap(gestureRecognizer: UIGestureRecognizer) {
        categoryTbl.beginUpdates()
        
        
        let section = gestureRecognizer.view!.tag
        
        func scrollToTop(animation:Bool=true) {
            DispatchQueue.main.async {
                let sectionIndexPath = IndexPath(row: NSNotFound, section: section)

                //let topRow = IndexPath(row: 0, section: section)
                self.categoryTbl.scrollToRow(at: sectionIndexPath,at: .top,animated: animation)

               
            }
        }
        
        func prePathsForSection(preSection:Int) -> [IndexPath] {
            var indexPaths = [IndexPath]()
            indexPaths.append(IndexPath(row: 0,section: preSection))
            return indexPaths
        }
        
        func indexPathsForSection() -> [IndexPath] {
            var indexPaths = [IndexPath]()
            indexPaths.append(IndexPath(row: 0,section: section))
            return indexPaths
        }
        
            
            if self.showSections.contains(section) {
                self.showSections.remove(section)
                self.categoryTbl.deleteRows(at: indexPathsForSection(),with: .fade)

                let hedar = self.categoryTbl.headerView(forSection: section)as! CategorysHeaderCell
                hedar.btnDropdown.setImage(#imageLiteral(resourceName: "rightArrow"), for: .normal)
                
                self.categoryTbl.endUpdates()
                categoryTbl.reloadSections(IndexSet(integer: section), with: .fade)
                scrollToTop(animation: false)
           
                
            } else {
                
                if self.showSections.count>0{
                    let preSection = self.showSections.first
                    self.showSections.remove(preSection!)
                    let hedar = self.categoryTbl.headerView(forSection: preSection!)as! CategorysHeaderCell
                    hedar.btnDropdown.setImage(#imageLiteral(resourceName: "rightArrow"), for: .normal)
                    
                    
                    self.categoryTbl.deleteRows(at: prePathsForSection(preSection: preSection!),with: .fade)
                    
                    
                }
                let item =  self.catItems![section]
                let params:[String:Any] = ["id": section,
                                           "n": item.companyName,
                                           "ult": item.latitude,
                                           "uln": item.longitude,
                                           "c": 1,
                                            "lt":item.latitude,
                                           "ln": item.longitude,
                                           "w": 375,
                                           "p": item.phoneNumeric,
                                           "u": item.joinURL,
                                           "jt": item.joinText,
                                           "a": item.address,
                                           "ct": item.city,
                                           "st": item.state,
                                           "z": item.zip,
                                           "s": item.waitSource,]
                ApiManager.shared.get(url: ApiUrls.itemLocation, params: params) { (res:ItemLocation?, err) in
                    if let error = err {
                        print("error in forgot password api :\(error)")
                    } else {

                        guard let resp = res else {return}
                        self.itemLocation = resp
                        self.showSections.insert(section)
                       print(">>>>\(resp)")
                        self.categoryTbl.insertRows(at: indexPathsForSection(),with: .fade)
                            
                        let hedar = self.categoryTbl.headerView(forSection: section)as! CategorysHeaderCell
                        hedar.layer.borderWidth = 0
                        hedar.btnDropdown.setImage(#imageLiteral(resourceName: "downArrow"), for: .normal)
                        self.categoryTbl.endUpdates()

                        scrollToTop(animation: true)
                        
                        
                    }
                }
                
                
                
                
        }
    }
}

//MARK:- ADITIONAL FUNCTION
extension SelectedCatVC{
    @objc func call(sender:UIButton) {
        
        let phoneNumber = self.catItems?[sender.tag].phoneDisplay ?? ""
        let cleanPhoneNumber = phoneNumber.components(separatedBy: CharacterSet.decimalDigits.inverted).joined(separator: "")
        let urlString:String = "tel://\(cleanPhoneNumber)"
        if let phoneCallURL = URL(string: urlString) {
            if (UIApplication.shared.canOpenURL(phoneCallURL)) {
                UIApplication.shared.open(phoneCallURL, options: [:], completionHandler: nil)
            }
        }
    }
    @objc func openAppleDirectionMap(sender:UIButton){
        let lat = self.catItems?[sender.tag].latitude ?? ""
        let lon = self.catItems?[sender.tag].longitude ?? ""
        //let url = URL(string: itemLocation?.directionsLink ?? "")

        let url = URL(string: "http://maps.apple.com/maps?saddr=&daddr=\(lat),\(lon)")
        UIApplication.shared.open(url!)
    }
    @objc func openUberRide(sender:UIButton){
        print(itemLocation?.rideLink ?? "")
        if let url = URL(string:itemLocation?.rideLink ?? "" ) {
            UIApplication.shared.open(url)
            
            
        }

    }
}

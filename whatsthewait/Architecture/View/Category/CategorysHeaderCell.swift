//
//  CategorysHeaderCell.swift
//  whatsthewait
//
//  Created by Harsh Rajput on 11/07/20.
//  Copyright © 2020 Harsh Rajput. All rights reserved.
//

import UIKit

class CategorysHeaderCell: UITableViewHeaderFooterView {
    @IBOutlet weak var btnCheckIn:UIButton!
    @IBOutlet weak var tapView:UIView!
    @IBOutlet weak var lblFeatured:UILabel!
    @IBOutlet weak var constrantTop: NSLayoutConstraint!
    @IBOutlet weak var companyName:UILabel!
    @IBOutlet weak var category:UILabel!
    @IBOutlet weak var address:UILabel!
    @IBOutlet weak var distance:UILabel!
    @IBOutlet weak var waitSource:UILabel!
    @IBOutlet weak var waitTimeDisplay:UILabel!
    @IBOutlet weak var catImg:UIImageView!
    @IBOutlet weak var isFeaturedView:UIView!
    @IBOutlet weak var btnDropdown:UIButton!



    var item : CategorysItem? = nil{
        didSet{
            btnDropdown.setImage(#imageLiteral(resourceName: "rightArrow"), for: .normal)
            companyName.text = item!.companyName.uppercased()
            category.text = item!.category
            distance.text = item!.distance + " mi"
            waitSource.text = item!.waitSource
            waitTimeDisplay.text = item!.waitTimeDisplay
            address.text = item!.address
            btnCheckIn.setTitle(item!.joinText, for: .normal)
            let average = Int(item!.waitTimeAverage) ?? 0
            if average <= 20{
                waitTimeDisplay.textColor = AppColors.primeryColorGreen
            }else if average >= 21 && average <= 40 {
                waitTimeDisplay.textColor = AppColors.primeryColorYellow
            }else if average >= 41 {
                waitTimeDisplay.textColor = AppColors.primeryColorRed
            }

            if item?.isFeatured == "1"{
                self.layer.borderWidth = 2
                self.layer.borderColor = AppColors.primeryColorMehroon.cgColor
                isFeaturedView.backgroundColor = AppColors.primeryColorMehroon
                lblFeatured.isHidden = false
                self.constrantTop.constant = 5
            }else{
                self.layer.borderWidth = 0
                isFeaturedView.backgroundColor = UIColor.white
                lblFeatured.isHidden = true
                self.constrantTop.constant = -5
            }
        }
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

//
//  HomeCell.swift
//  whatsthewait
//
//  Created by Harsh Rajput on 09/07/20.
//  Copyright © 2020 Harsh Rajput. All rights reserved.
//

import UIKit

class HomeCell: UITableViewCell {

     @IBOutlet private weak var lblItem: UILabel!
     @IBOutlet private weak var imgItem: UIImageView!
    var dfultCell:Int? = nil{
        didSet{
            lblItem.text = "Contact Us"
            imgItem.image = #imageLiteral(resourceName: "contect1")
        }
    }
    var catItem : Categorys? = nil{
        didSet {
            lblItem.text = catItem?.name
            guard catItem?.isEnabled == "1" else {
                lblItem.textColor = .lightGray
                imgItem.sd_setImage(with: URL(string: catItem!.iconURLDisabled))

                return
            }
            lblItem.textColor = .black
            imgItem.sd_setImage(with: URL(string: catItem!.iconURL))

           }
    }
        
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

            
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

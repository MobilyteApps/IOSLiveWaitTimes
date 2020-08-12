//
//  CategoryCell.swift
//  whatsthewait
//
//  Created by Harsh Rajput on 11/07/20.
//  Copyright © 2020 Harsh Rajput. All rights reserved.
//

import UIKit
import SDWebImage
import SwiftGifOrigin

class CategoryCell: UITableViewCell {
    @IBOutlet weak var imgMap:UIImageView!
    @IBOutlet weak var btnPhone:UIButton!
    @IBOutlet weak var btnUber:UIButton!
    @IBOutlet weak var btnDirection:UIButton!
     @IBOutlet weak var btnDirectionMap:UIButton!
    var item:CategorysItem?=nil{
        didSet{
            let url = "https://api.mapbox.com/styles/v1/mapbox/streets-v11/static/url-https%3A%2F%2Fwww.livewaittimes.com%2Fimages%2Fmap-pin.png(\(item!.longitude),\(item!.latitude))/\(item!.longitude),\(item!.latitude),15/300x200@2x?access_token=pk.eyJ1IjoibGl2ZXdhaXR0aW1lcyIsImEiOiJja2NxZGtlcXAwbHR4MnptMXp2czlzdHNyIn0.l19gojULIw0DoeeLHLbRTQ"
            print("==>\(url)")
            imgMap.sd_setImage(with: URL(string: url), placeholderImage: UIImage.gif(name: "loader"))
            if item?.isFeatured == "1"{
               
                self.contentView.backgroundColor = AppColors.primeryColorMehroon
            }else{
                self.contentView.backgroundColor = UIColor.white
            }

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

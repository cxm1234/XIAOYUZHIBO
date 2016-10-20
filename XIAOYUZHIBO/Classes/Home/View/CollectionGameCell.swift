//
//  CollectionGameCell.swift
//  XIAOYUZHIBO
//
//  Created by xiaoming on 16/10/3.
//  Copyright © 2016年 xiaoming. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionGameCell: UICollectionViewCell {
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!

    //MARK 
    var baseGame : BaseGameModel?{
        didSet{
            titleLabel.text=baseGame?.tag_name
            if let iconURL = URL(string: baseGame?.icon_url ?? ""){
                iconImageView.kf.setImage(with: iconURL)
            }else{
                iconImageView.image=UIImage(named:"home_more_btn")
            }
        }
    }
}

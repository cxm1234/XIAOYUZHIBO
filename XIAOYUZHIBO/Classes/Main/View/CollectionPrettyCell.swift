//
//  CollectionPrettyCell.swift
//  XIAOYUZB
//
//  Created by xiaoming on 16/9/23.
//  Copyright © 2016年 xiaoming. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionPrettyCell: CollectionBaseCell {
    
    @IBOutlet weak var cityBtn: UIButton!

    //定义模型属性
    override var anchor : AnchorModel?{
        didSet{
            
            super.anchor=anchor
            
            //0.校验模型是否有值
            //昵称的显示
            
            cityBtn.setTitle(anchor?.anchor_city, for: .normal)
            
        }
    }
}


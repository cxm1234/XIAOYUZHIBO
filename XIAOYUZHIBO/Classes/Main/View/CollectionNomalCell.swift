//
//  CollectionNomalCell.swift
//  XIAOYUZB
//
//  Created by xiaoming on 16/9/23.
//  Copyright © 2016年 xiaoming. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionNomalCell: CollectionBaseCell {

    @IBOutlet weak var roomNameLabel: UILabel!
    
    override var anchor : AnchorModel?{
        didSet{
            super.anchor=anchor
            roomNameLabel.text = anchor?.room_name
        }

    }

}

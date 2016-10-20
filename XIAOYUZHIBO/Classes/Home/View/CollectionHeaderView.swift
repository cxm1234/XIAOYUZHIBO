//
//  CollectionHeaderView.swift
//  XIAOYUZB
//
//  Created by xiaoming on 16/9/23.
//  Copyright © 2016年 xiaoming. All rights reserved.
//

import UIKit

class CollectionHeaderView: UICollectionReusableView {

    @IBOutlet weak var moreBtn: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    var group : AnchorGroup?{
        didSet{
            titleLabel.text = group?.tag_name
            iconImageView.image = UIImage(named: group?.icon_name ?? "home_header_normal")
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}


extension CollectionHeaderView{
    class func collectionHeaderView() -> CollectionHeaderView{
        return Bundle.main.loadNibNamed("CollectionHeaderView", owner: nil, options: nil)?.first as! CollectionHeaderView
    }
}

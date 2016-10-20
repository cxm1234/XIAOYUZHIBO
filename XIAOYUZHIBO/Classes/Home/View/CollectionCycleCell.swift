//
//  CollectionCycleCell.swift
//  XIAOYUZHIBO
//
//  Created by xiaoming on 16/9/30.
//  Copyright © 2016年 xiaoming. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionCycleCell: UICollectionViewCell {
    @IBOutlet weak var iconImageView: UIImageView!

    @IBOutlet weak var titleLabel: UILabel!
    var cycleModel : CycleModel?{
        didSet{
            titleLabel.text = cycleModel?.title
            let iconURL = URL(string: cycleModel?.pic_url ?? "");
            iconImageView.kf.setImage(with: iconURL)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()

        
    }

}

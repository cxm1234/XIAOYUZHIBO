//
//  CollectionBaseCell.swift
//  XIAOYUZHIBO
//
//  Created by xiaoming on 16/9/29.
//  Copyright © 2016年 xiaoming. All rights reserved.
//

import UIKit

class CollectionBaseCell: UICollectionViewCell {
   
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var onlineButton: UIButton!
    @IBOutlet weak var iconImageView: UIImageView!
    
    
    var anchor : AnchorModel?{
        didSet{
            //0.校验模型是否有值
            guard let anchor = anchor else {
                return
            }
            var onlineStr :String = ""
            if anchor.online >= 10000 {
                onlineStr = "\(Int(anchor.online / 10000))万在线"
            }else{
                onlineStr = "\(anchor.online)在线"
            }
            
            onlineButton.setTitle(onlineStr, for:.normal)
            
            //昵称的显示
            nickNameLabel.text = anchor.nickName
            
            //设置封面图片
            guard let iconURL = URL(string:anchor.vertical_src)  else {
                return
            }
            iconImageView?.kf.setImage(with:iconURL)
        }
    }
    
    
}

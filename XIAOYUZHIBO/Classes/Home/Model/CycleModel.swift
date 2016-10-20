//
//  CycleModel.swift
//  XIAOYUZHIBO
//
//  Created by xiaoming on 16/9/29.
//  Copyright © 2016年 xiaoming. All rights reserved.
//

import UIKit

class CycleModel: NSObject {
     //标题
    var title : String = ""
    var pic_url : String = ""
    //主播信息对应的字典
    var room : [String : NSObject]? {
        didSet{
            guard let room = room else { return }
            anchor = AnchorModel(dict: room)
        }
    }
    
    init(dict : [String : NSObject]){
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
    var anchor : AnchorModel?

}

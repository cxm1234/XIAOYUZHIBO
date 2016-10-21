//
//  AnchorModel.swift
//  XIAOYUZHIBO
//
//  Created by xiaoming on 16/9/26.
//  Copyright © 2016年 xiaoming. All rights reserved.
//

import UIKit

class AnchorModel: NSObject {
    var room_id : Int = 0
    var vertical_src : String = ""
    //判断是手机直播还是电脑直播
    // 0 : 电脑直播 1 : 手机直播
    var isVertical : Int = 0
    var room_name : String = ""
    //主播昵称
    var nickName : String = ""
    var online : Int = 0
    var anchor_city : String = ""
    init(dict : [String : Any]){
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}

//
//  BaseGameModel.swift
//  XIAOYUZHIBO
//
//  Created by xiaoming on 16/10/19.
//  Copyright © 2016年 xiaoming. All rights reserved.
//

import UIKit

class BaseGameModel: NSObject {
    var tag_name : String = ""
    var icon_url : String = ""
    
    
    init(dict : [String : Any]){
        super.init()
        setValuesForKeys(dict)
    }
    
    override init(){
        
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}

//
//  NSDate-Extension.swift
//  XIAOYUZHIBO
//
//  Created by xiaoming on 16/9/26.
//  Copyright © 2016年 xiaoming. All rights reserved.
//

import Foundation

extension NSDate{
    static func getCurrentTime()->String{
        let nowDate = NSDate()
        let interval = Int(nowDate.timeIntervalSince1970)
        return "\(interval)"
    }
}

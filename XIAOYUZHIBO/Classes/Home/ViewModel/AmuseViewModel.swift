//
//  AmuseViewModel.swift
//  XIAOYUZHIBO
//
//  Created by xiaoming on 16/10/20.
//  Copyright © 2016年 xiaoming. All rights reserved.
//

import UIKit

class AmuseViewModel{
    lazy var anchorGroups : [AnchorGroup] = [AnchorGroup]()
}


extension AmuseViewModel{
    func loadAmuseData(finishedCallback : @escaping () -> ()){
        NetworkTools.requestData(type: .get, URLString: "http://capi.douyucdn.cn/api/v1/getHotRoom/2") { (result) in
            //
            guard let resultDict = result as? [String : Any] else {return}
            guard let dataArray = resultDict["data"] as? [[String : Any]] else {return}
            
            //遍历数组中的字典
            for dict in dataArray{
                self.anchorGroups.append(AnchorGroup(dict: dict))
            }
            
            
            
            finishedCallback()
        }
    }
}

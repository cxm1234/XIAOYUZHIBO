//
//  AmuseViewModel.swift
//  XIAOYUZHIBO
//
//  Created by xiaoming on 16/10/20.
//  Copyright © 2016年 xiaoming. All rights reserved.
//

import UIKit

class AmuseViewModel : BaseViewModel{
    
}


extension AmuseViewModel{
    func loadAmuseData(finishedCallback : @escaping () -> ()){
            loadAnchorData(isGroupData: true,URLString: "http://capi.douyucdn.cn/api/v1/getHotRoom/2", finishedCallback: finishedCallback)
    }
}


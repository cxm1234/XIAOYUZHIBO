
//
//  FunnyViewModel.swift
//  XIAOYUZHIBO
//
//  Created by xiaoming on 16/10/21.
//  Copyright © 2016年 xiaoming. All rights reserved.
//

import UIKit

class FunnyViewModel: BaseViewModel {

}

extension FunnyViewModel{
    func loadFunnyData(finishedCallback : @escaping ()->()){
        loadAnchorData(isGroupData: false,URLString: "http://capi.douyucdn.cn/api/v1/getColumnRoom/3", parameters: ["limit" : 30,"offset" : 0]) {
            finishedCallback()
        }
        
    }
}

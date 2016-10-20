//
//  GameViewModel.swift
//  XIAOYUZHIBO
//
//  Created by xiaoming on 16/10/15.
//  Copyright © 2016年 xiaoming. All rights reserved.
//

import UIKit

class GameViewModel: NSObject {
    lazy var games : [GameModel] = [GameModel]()
}

extension GameViewModel{
    func loadAllGameData(finishedCallback:@escaping()->()){
        NetworkTools.requestData(type: .get, URLString: "http://capi.douyucdn.cn/api/v1/getColumnDetail", parameters: ["shortName" : "game"]){(result) in
            guard let resultDict = result as? [String : Any] else {return}
            guard let dataArray = resultDict["data"] as? [[String : Any]] else {return}
            
            for dict in dataArray{
                self.games.append(GameModel(dict: dict))
            }
            
            finishedCallback()
        }
    }
}

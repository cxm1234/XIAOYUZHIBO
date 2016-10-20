//
//  RecommendViewModel.swift
//  XIAOYUZHIBO
//
//  Created by xiaoming on 16/9/26.
//  Copyright © 2016年 xiaoming. All rights reserved.
//

import UIKit

class RecommendViewModel{
    
    lazy var cycleModels : [CycleModel] = [CycleModel]()
    lazy var anchorGroups : [AnchorGroup] = [AnchorGroup]()
    lazy var bigDataGroup : AnchorGroup = AnchorGroup()
    lazy var prettyGroup : AnchorGroup = AnchorGroup()
}

//MARK:- 发送网络请求
extension RecommendViewModel{
    func  requestData(finishedCallback : @escaping ()->()){
        let dGroup = DispatchGroup()
        
        let nowDate = NSDate.getCurrentTime()
        print(nowDate)
//        print(nowDate)
        //1.请求第一部分推荐数据
        dGroup.enter()
        NetworkTools.requestData(type: .get, URLString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom?time:\(nowDate)", parameters: nil) { (result) in
            guard let resultDict = result as? [String : NSObject] else {
                return
            }
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else{
                return
            }
            self.bigDataGroup.tag_name = "热门"
            self.bigDataGroup.icon_name = "home_header_hot"
            
            for dict in dataArray{
                let anchor = AnchorModel(dict: dict)
                self.bigDataGroup.anchors.append(anchor)
            }
            dGroup.leave()
//            print("请求到0组数据")
        }
        
        
        //2.请求第二部分颜值数据
        dGroup.enter()
        NetworkTools.requestData(type: .get, URLString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom?limit=4&offset=0&time=\(nowDate)", parameters: nil) { (result) in
//            print(result)
            guard let resultDict = result as? [String : NSObject] else {
                return
            }
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else{
                return
            }
            
            self.prettyGroup.tag_name = "颜值"
            self.prettyGroup.icon_name = "home_header_phone"
            
            for dict in dataArray{
                let anchor = AnchorModel(dict: dict)
                self.prettyGroup.anchors.append(anchor)
            }
            dGroup.leave()
//            print("请求到1组数据")
        }
    
        
        //3.请求后面部分游戏数据
        // ["time":NSDate.getCurrentTime() as NSString,"limit":"4","offset":"0"]
        
        let urlString = "http://capi.douyucdn.cn/api/v1/getHotCate?limit=4&offset=0&time=\(nowDate)"
        dGroup.enter()
        NetworkTools.requestData(type:.get, URLString:urlString,parameters:nil){ (result) in
            guard let resultDict = result as? [String : NSObject] else {
                return
            }
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else{
                return
            }
            
            for dict in dataArray{
                let group = AnchorGroup(dict: dict)
                self.anchorGroups.append(group)
            }
            
            dGroup.leave()
        }
        
        dGroup.notify(queue: DispatchQueue.main) { 
//            print("所有数据都请求到")
            self.anchorGroups.insert(self.prettyGroup, at: 0)
            self.anchorGroups.insert(self.bigDataGroup, at: 0)
            finishedCallback()
        }

    }
    
    
    func requestCycleData(finishCallback : @escaping ()->()){
        NetworkTools.requestData(type: .get, URLString: "http://www.douyutv.com/api/v1/slide/6?version=2.300", parameters: nil) { (result) in
            
            guard let resultDict = result as? [String : NSObject] else { return }
            
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else {return}
            
            for dict in dataArray {
                let cycleModel = CycleModel(dict: dict);
                self.cycleModels.append(cycleModel)
            }
            
            print(result)
            finishCallback()
        }
        
    }
}

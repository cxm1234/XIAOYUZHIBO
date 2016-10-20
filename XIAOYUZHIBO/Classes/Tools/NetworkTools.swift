//
//  NetworkTools.swift
//  AlamofireTest
//
//  Created by xiaoming on 16/9/24.
//  Copyright © 2016年 xiaoming. All rights reserved.
//

import UIKit
import Alamofire

enum MethodType {
    case get
    case post
}

class NetworkTools{
    class func requestData(type:MethodType ,URLString:String,parameters:[String:Any]?=nil,finishedCallback:@escaping (_ result:Any)->()){
        
        
        let method = type == .get ? HTTPMethod.get : HTTPMethod.post
        Alamofire.request(URLString, method:method, parameters:parameters).responseJSON{ response in
                guard let result = response.result.value else {
                return
                }
                finishedCallback(result)
            }
    }
}

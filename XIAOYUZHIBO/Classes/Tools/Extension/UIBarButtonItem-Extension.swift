
//
//  UIBarButtonItem-Extension.swift
//  XIAOYUZB
//
//  Created by xiaoming on 16/9/17.
//  Copyright © 2016年 xiaoming. All rights reserved.
//

import UIKit

extension UIBarButtonItem{
    
//    class func createItem(imageName:String,highImageName:String,size:CGSize=CGSizeZero)->UIBarButtonItem{
//        let btn=UIButton()
//        btn.setImage(UIImage(named: imageName), forState: .Normal)
//        if highImageName != ""{
//            btn.setImage(UIImage(named: highImageName), forState: .Highlighted)
//        }
//        btn.frame=CGRect(origin: CGPointZero, size: size)
//        
//        return UIBarButtonItem(customView: btn)
//    }
    
    
    //便利构造函数1>
    convenience init(imageName:String,highImageName:String="",size:CGSize=CGSize.zero) {
        let btn=UIButton()
        btn.setImage(UIImage(named: imageName), for: .normal)
        if highImageName != "" {
            btn.setImage(UIImage(named: highImageName), for: .highlighted)
        }
        
        if size == CGSize.zero{
            btn.sizeToFit()
        }else{
            btn.frame = CGRect(origin: CGPoint.zero, size: size)
        }
        
        
        self.init(customView:btn)
    }
    
}

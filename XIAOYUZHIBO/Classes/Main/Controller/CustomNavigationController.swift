//
//  CustomNavigationController.swift
//  XIAOYUZHIBO
//
//  Created by xiaoming on 16/10/21.
//  Copyright © 2016年 xiaoming. All rights reserved.
//

import UIKit

class CustomNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let systemGes = interactivePopGestureRecognizer else {return}
        //获取手势添加到的View中
        guard let gesView = systemGes.view else {return}
        
        let targets = systemGes.value(forKey: "_targets") as? [NSObject]
        guard let targetObjc = targets?.first else {return}
        
        
        //获取target/action
        guard let target = targetObjc.value(forKey: "target") else {return}
        //取出action
        let action = Selector(("handleNavigationTransition:"))
        
        //创建自己的手势
        let panGes = UIPanGestureRecognizer()
        gesView.addGestureRecognizer(panGes)
        panGes.addTarget(target, action: action)
        //利用运行时机制查看所有的属性名称
//        var count : UInt32 = 0
//        let ivars = class_copyIvarList(UIGestureRecognizer.self, &count)!
//        for i in 0..<count{
//            let ivar = ivars[Int(i)]
//            let name = ivar_getName(ivar)
//            print(String(cString: name!))
//        }
        
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        viewController.hidesBottomBarWhenPushed = true
        super.pushViewController(viewController, animated: animated)
    }

}

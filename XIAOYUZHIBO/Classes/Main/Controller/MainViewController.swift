//
//  MainViewController.swift
//  XIAOYUZB
//
//  Created by xiaoming on 16/9/17.
//  Copyright © 2016年 xiaoming. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //
        addChildVc("Home")
        addChildVc("Live")
        addChildVc("Follow")
        addChildVc("Profile")
        
    }
    
    fileprivate func addChildVc(_ storyName:String){
        let childVc=UIStoryboard(name:storyName,bundle: nil).instantiateInitialViewController()!
        addChildViewController(childVc)
    }
    
}

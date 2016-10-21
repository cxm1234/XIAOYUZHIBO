//
//  HomeViewController.swift
//  XIAOYUZB
//
//  Created by xiaoming on 16/9/17.
//  Copyright © 2016年 xiaoming. All rights reserved.
//

import UIKit
let kTitleViewH:CGFloat = 40
class HomeViewController: UIViewController {
    
    lazy var  pageTitleView:PageTitleView = {[weak self] in
        let titleFrame=CGRect(x:0, y: kStatusBarH+kNavigationBarH, width:kScreenW, height:kTitleViewH)
        let titles=["推荐","游戏","娱乐","趣玩"]
        let titleView=PageTitleView(frame:titleFrame,titles:titles)
//        titleView.backgroundColor=UIColor.red
        titleView.delegate = self
        return titleView
    }()
    
    lazy var pageContentView : PageContentView = {[weak self] in
        let contenH = kScreenH - kStatusBarH-kTitleViewH-kTabbarH
        let contentFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH + kTitleViewH, width: kScreenW, height: contenH)
        
        var childVcs = [UIViewController]()
        childVcs.append(RecommendViewController())
        childVcs.append(GameViewController())
        childVcs.append(AmuseViewController())
        childVcs.append(FunnyViewController())
        let contentView = PageContentView(frame: contentFrame, childVcs: childVcs, parentViewController: self)
        contentView.delegate = self
        return contentView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
    }
    
}


// MARK:- 设置UI界面
extension HomeViewController
{
     func setupUI(){
        automaticallyAdjustsScrollViewInsets = false
        
        setupNavigationBar()
        
        //添加titleView
        view.addSubview(pageTitleView)
        view.addSubview(pageContentView)
    }
    
    fileprivate func setupNavigationBar(){
        let btn=UIButton()
        btn.setImage(UIImage(named: "logo"), for: .normal)
        btn.sizeToFit()
        navigationItem.leftBarButtonItem=UIBarButtonItem(customView:btn)
        let size=CGSize(width: 40, height: 40)
        let historyItem=UIBarButtonItem(imageName: "image_my_history", highImageName: "Image_my_history_click", size: size)
        let searchItem=UIBarButtonItem(imageName: "btn_search", highImageName: "btn_search_clicked", size: size)
        let qrcodeItem=UIBarButtonItem(imageName: "Image_scan", highImageName: "Image_scan_click", size: size)
        navigationItem.rightBarButtonItems=[historyItem,searchItem,qrcodeItem];
    }
}


extension HomeViewController : PageTitleViewDelegate{
    func pageTitleView(_ titleView: PageTitleView, selectedIndex index: Int) {
        pageContentView.setCurrentIndex(index)
    }
}

extension HomeViewController : PageContentViewDelegate{
    
    func pageContentView(_ contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
           pageTitleView.setTitleWithProgress(progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}

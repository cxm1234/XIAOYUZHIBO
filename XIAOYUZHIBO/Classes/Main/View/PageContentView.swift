//
//  PageContentView.swift
//  XIAOYUZB
//
//  Created by xiaoming on 16/9/19.
//  Copyright © 2016年 xiaoming. All rights reserved.
//

import UIKit

protocol PageContentViewDelegate : class {
    func pageContentView(_ contentView : PageContentView, progress : CGFloat, sourceIndex : Int,targetIndex : Int)
}

private let ContentCellID = "ContentCellID"

class PageContentView: UIView {
    
    var childVcs : [UIViewController]
    weak var parentViewController : UIViewController?
    var startOffsetX : CGFloat = 0
    var isForbidScrollDelegate : Bool = false
    weak var delegate : PageContentViewDelegate?
    
    lazy var collectionView : UICollectionView = {[weak self] in
       let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: ContentCellID)
        
        return collectionView
    }()
    
    
    init(frame : CGRect,childVcs : [UIViewController],parentViewController : UIViewController?){
        self.childVcs = childVcs
        self.parentViewController = parentViewController
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}


extension PageContentView {
     func setupUI() {
        for childVc in childVcs {
            parentViewController?.addChildViewController(childVc)
        }
        // 2.添加UICollectionView
        addSubview(collectionView)
        collectionView.frame = bounds
    }
}

extension PageContentView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCellID, for: (indexPath as NSIndexPath) as IndexPath)
        //给Cell设置内容
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        let childVc = childVcs[indexPath.item]
        childVc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVc.view)
        
        return cell
    }
}

extension PageContentView : UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if isForbidScrollDelegate { return }
        //获取需要的数据
//        let scrollView.contentOffset
        var progress : CGFloat = 0
        
        var sourceIndex : Int = 0
        
        var targetIndex : Int = 0
        
        let currentOffsetX = scrollView.contentOffset.x
        let scrollViewW = scrollView.bounds.width
        
        if currentOffsetX > currentOffsetX { //左滑
            progress = currentOffsetX / scrollViewW - floor(currentOffsetX/scrollViewW)
            //计算sourceIndex
            sourceIndex = Int(currentOffsetX/scrollViewW)
            targetIndex = sourceIndex + 1
            if targetIndex >= childVcs.count - 1 {
                targetIndex = childVcs.count - 1
            }
            
            //
            if currentOffsetX - currentOffsetX == scrollViewW {
                progress = 1
                targetIndex = sourceIndex
            }
            
        } else { //右滑
            progress = 1 - (currentOffsetX / scrollViewW - floor(currentOffsetX/scrollViewW))
            targetIndex = Int(currentOffsetX / scrollViewW)
            sourceIndex = targetIndex + 1
            if sourceIndex >= childVcs.count{
                sourceIndex = childVcs.count - 1
            }
        }
        
//        print("progress:\(progress) sourceIndex:\(sourceIndex) targetIndex:\(targetIndex)")
        
        delegate?.pageContentView(self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isForbidScrollDelegate = false
        startOffsetX = scrollView.contentOffset.x
    }
}


extension PageContentView {
    func setCurrentIndex(_ currentIndex : Int) {
        //记录需要禁止的代理方法
        isForbidScrollDelegate = true
//        print("setCurrentIndex----\(currentIndex)")
        let offsetX = CGFloat(currentIndex) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x: offsetX,y: 0), animated: false)
        
    }
    
    
}

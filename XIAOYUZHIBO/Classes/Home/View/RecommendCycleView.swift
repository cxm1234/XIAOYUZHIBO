//
//  RecommendCycleView.swift
//  XIAOYUZHIBO
//
//  Created by xiaoming on 16/9/29.
//  Copyright © 2016年 xiaoming. All rights reserved.
//

import UIKit

private let kCycleCellID = "kCycleCellID"

class RecommendCycleView: UIView {
    
    
    var cycleTimer : Timer?
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    var cycleModels : [CycleModel]?{
        didSet{
            //刷新
            collectionView.reloadData()
            //设置pageControl的个数
            pageControl.numberOfPages = cycleModels?.count ?? 0
            
            //默认滚动到中间某一个位置
            let indexPath = NSIndexPath(item: (cycleModels?.count ?? 0) * 100, section: 0)
            collectionView.scrollToItem(at: indexPath as IndexPath, at: .left, animated: false)
            
            removeCycleTimer()
            addCycleTimer()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        autoresizingMask = []
        
        collectionView.register(UINib(nibName: "CollectionCycleCell", bundle: nil), forCellWithReuseIdentifier: kCycleCellID)

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collectionView.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        collectionView.isPagingEnabled = true
    }
}

extension RecommendCycleView : UICollectionViewDataSource{
    func collectionView(_ collectionView:UICollectionView,numberOfItemsInSection section: Int) -> Int {
        return (cycleModels?.count ?? 0) * 10000
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCycleCellID, for: indexPath) as! CollectionCycleCell
        
        let cycleModel = cycleModels![indexPath.item % cycleModels!.count]
        
        cell.cycleModel = cycleModel
        
        return cell
    }
}


extension RecommendCycleView{
    class func recommendCycleView() -> RecommendCycleView{
        return Bundle.main.loadNibNamed("RecommendCycleView", owner: nil, options: nil)!.first as! RecommendCycleView
        
    }
}

extension RecommendCycleView : UICollectionViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //获取滚动的偏移量
        let offsetX = scrollView.contentOffset.x + scrollView.bounds.width * 0.5
        pageControl.currentPage = Int(offsetX / scrollView.bounds.width) % (cycleModels?.count ?? 1)
    }
    
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        removeCycleTimer()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        addCycleTimer()
    }
}

extension RecommendCycleView{
    func addCycleTimer(){
        cycleTimer = Timer(timeInterval: 3.0, target: self, selector: #selector(self.scrollToNext), userInfo: nil, repeats: true)
        RunLoop.main.add(cycleTimer!, forMode: RunLoopMode.commonModes)
        
    }
    
    func removeCycleTimer(){
        cycleTimer?.invalidate()
        cycleTimer = nil
    }
    
    @objc private func scrollToNext(){
        let currentOffsetX = collectionView.contentOffset.x
        let offsetX = currentOffsetX + collectionView.bounds.width
        collectionView.setContentOffset(CGPoint(x:offsetX,y:0), animated: true)
    }
    
}



//
//  RecommendGameView.swift
//  XIAOYUZHIBO
//
//  Created by xiaoming on 16/10/2.
//  Copyright © 2016年 xiaoming. All rights reserved.
//

import UIKit

private let kGameCellID = "kGameCellID"
private let kEdgeInsetMargin : CGFloat = 10

class RecommendGameView: UIView {
    
    //MARK: 定义数据的属性
    var groups : [BaseGameModel]?{
        didSet{
            //刷新表格
            collectionView.reloadData()
        }
    }
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func awakeFromNib() {
        
        autoresizingMask = UIViewAutoresizing()
        collectionView.register(UINib(nibName: "CollectionGameCell", bundle: nil),forCellWithReuseIdentifier:kGameCellID)
        collectionView.contentInset = UIEdgeInsetsMake(0, kEdgeInsetMargin, 0, kEdgeInsetMargin)
        
    }
}



extension RecommendGameView{
    class func recommendGameView() -> RecommendGameView {
        return Bundle.main.loadNibNamed("RecommendGameView", owner: nil, options: nil)?.first as! RecommendGameView
    }
}

extension RecommendGameView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellID, for: indexPath) as! CollectionGameCell
        
        cell.baseGame = groups![indexPath.item]
        return cell
    }
}

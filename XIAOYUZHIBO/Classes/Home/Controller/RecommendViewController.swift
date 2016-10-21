//
//  RecommendViewController.swift
//  XIAOYUZB
//
//  Created by xiaoming on 16/9/22.
//  Copyright © 2016年 xiaoming. All rights reserved.
//

import UIKit

//private let kItemMargin : CGFloat = 10
//private let kItemW = (kScreenW - 3 * kItemMargin)/2
//private let kNormalItemH = kItemW * 3 / 4
//private let kPrettyItemH = kItemW * 4 / 3
//private let kHeaderViewH : CGFloat = 50
//
//private let kNormalCellID = "kNormalCellID"
//private let kPrettyCellID = "kPrettyCellID"
//private let kHeaderViewID = "kHeaderViewID"
//
private let kCycleViewH = kScreenW * 3 / 8
//
private let kGameViewH : CGFloat = 90


class RecommendViewController: BaseAnchorViewController {
    
    lazy var recommendVM:RecommendViewModel=RecommendViewModel()
    lazy var cycleView : RecommendCycleView = {
        let cycleView = RecommendCycleView.recommendCycleView()
        cycleView.frame = CGRect(x: 0, y: -(kCycleViewH+kGameViewH), width: kScreenW, height: kCycleViewH)
        return cycleView;
    }()
    lazy var gameView : RecommendGameView = {
        let gameView = RecommendGameView.recommendGameView()
        gameView.frame = CGRect(x: 0, y: -kGameViewH, width: kScreenW, height: kGameViewH)
        return gameView
    }()
    
}


extension RecommendViewController{
   override func loadData(){
        baseVM = recommendVM
        recommendVM.requestData(){
            self.collectionView.reloadData()
            var groups = self.recommendVM.anchorGroups
            groups.removeFirst()
            groups.removeFirst()
            //将数据
            self.gameView.groups = groups
            super.loadDataFinished()
        }
        recommendVM.requestCycleData {
            print("数据请求完成")
            self.cycleView.cycleModels = self.recommendVM.cycleModels
        }
    
    }
}

extension RecommendViewController{
    override func setupUI(){
        super.setupUI()
        collectionView.addSubview(cycleView)
        collectionView.addSubview(gameView)
        collectionView.contentInset = UIEdgeInsets(top: kCycleViewH+kGameViewH, left: 0, bottom: 0, right: 0)
        
    }
}

extension RecommendViewController : UICollectionViewDelegateFlowLayout{
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 1{
            //1.取出PrettyCell
            let prettyCell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellID, for: indexPath) as! CollectionPrettyCell
            prettyCell.anchor = recommendVM.anchorGroups[indexPath.section].anchors[indexPath.item]
            return prettyCell
        }else{
            return super.collectionView(collectionView,cellForItemAt: indexPath)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout : UICollectionViewLayout,sizeForItemAt indexPath: IndexPath) -> CGSize{
        
        if indexPath.section == 1{
            return CGSize(width: kNormalItemW, height: kPrettyItemH)
        }
        
        return CGSize(width: kNormalItemW, height: kNormalItemH)
        
    }
}


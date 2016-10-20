//
//  RecommendViewController.swift
//  XIAOYUZB
//
//  Created by xiaoming on 16/9/22.
//  Copyright © 2016年 xiaoming. All rights reserved.
//

import UIKit

private let kItemMargin : CGFloat = 10
private let kItemW = (kScreenW - 3 * kItemMargin)/2
private let kNormalItemH = kItemW * 3 / 4
private let kPrettyItemH = kItemW * 4 / 3
private let kHeaderViewH : CGFloat = 50

private let kNormalCellID = "kNormalCellID"
private let kPrettyCellID = "kPrettyCellID"
private let kHeaderViewID = "kHeaderViewID"

private let kCycleViewH = kScreenW * 3 / 8

private let kGameViewH : CGFloat = 90


class RecommendViewController: UIViewController {
    
     lazy var recommendVM:RecommendViewModel=RecommendViewModel()

     lazy var collectionView : UICollectionView = { [unowned self] in
        //创建布局
        let layout = UICollectionViewFlowLayout()
        
        layout.itemSize = CGSize(width: kItemW, height: kNormalItemH)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = kItemMargin
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
        
        
        let collectionView = UICollectionView(frame:self.view.bounds , collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        collectionView.register(UINib(nibName: "CollectionNomalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
        collectionView.register(UINib(nibName: "CollectionPrettyCell", bundle: nil), forCellWithReuseIdentifier: kPrettyCellID)
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
        return collectionView
    }()
    
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
    
    //MARK:- 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadData()
    }
}


extension RecommendViewController{
    func loadData(){
        //这里没有循环引用
        recommendVM.requestData(){
            self.collectionView.reloadData()
            
            
            var groups = self.recommendVM.anchorGroups
            
            groups.removeFirst()
            groups.removeFirst()
            
            //将数据
            self.gameView.groups = groups
        }
        
        recommendVM.requestCycleData {
            print("数据请求完成")
            self.cycleView.cycleModels = self.recommendVM.cycleModels
        }
    }
}

extension RecommendViewController{
     func setupUI(){
        view.addSubview(_:collectionView)
        //将CycleView添加到UiCollectionView上
        collectionView.addSubview(cycleView)
        
        //将gameView加到collectionView上
        collectionView.addSubview(gameView)
        collectionView.contentInset = UIEdgeInsets(top: kCycleViewH+kGameViewH, left: 0, bottom: 0, right: 0)
        
    }
}



extension RecommendViewController : UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int{
        let num = recommendVM.anchorGroups.count
        return num
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let group = recommendVM.anchorGroups[section]
        
        return group.anchors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let group = recommendVM.anchorGroups[indexPath.section]
        let anchor = group.anchors[indexPath.item];
        
        var cell : CollectionBaseCell
        
        if indexPath.section == 1{
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellID, for: indexPath) as! CollectionPrettyCell
            
        }else{
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! CollectionNomalCell
        }
        cell.anchor=anchor
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath as IndexPath) as! CollectionHeaderView
        //取出模型
        headerView.group = recommendVM.anchorGroups[indexPath.section]
        
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1{
            return CGSize(width:kItemW,height:kPrettyItemH)
        }
        return CGSize(width:kItemW,height:kNormalItemH)
    }
}

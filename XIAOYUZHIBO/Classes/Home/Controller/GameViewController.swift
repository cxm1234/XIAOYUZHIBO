//
//  GameViewController.swift
//  XIAOYUZHIBO
//
//  Created by xiaoming on 16/10/14.
//  Copyright © 2016年 xiaoming. All rights reserved.
//

import UIKit

private let kEdgeMargin : CGFloat = 10
private let kItemW : CGFloat = (kScreenW - 2*kEdgeMargin)/3
private let kItemH : CGFloat = kItemW * 6 / 5;
private let kHeaderViewH : CGFloat = 50

private let kGameCellID = "kGameCellID"

private let kHeaderViewID = "kHeaderViewID"

private let kGameViewH : CGFloat = 90

class GameViewController: UIViewController {
    
    fileprivate lazy var gameVM : GameViewModel = GameViewModel()
    //MARK: 懒加载属性
    fileprivate lazy var collectionView : UICollectionView = {[unowned self] in
        //创建布局
        let layout=UICollectionViewFlowLayout()
        layout.itemSize=CGSize(width: kItemW, height: kItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: kEdgeMargin, bottom: 0, right: kEdgeMargin)
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
        let collectionView=UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        
        collectionView.register(UINib(nibName:"CollectionGameCell",bundle:nil), forCellWithReuseIdentifier: kGameCellID)
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
        collectionView.dataSource = self
        return collectionView
    }()
    
    fileprivate lazy var topHeaderView : CollectionHeaderView = {
       let headerView = CollectionHeaderView.collectionHeaderView()
        headerView.frame = CGRect(x: 0, y: -(kHeaderViewH+kGameViewH), width: kScreenW, height: kHeaderViewH)
        headerView.iconImageView.image = UIImage(named: "Img_orange")
        headerView.titleLabel.text = "常见"
        headerView.moreBtn.isHidden = true
        
        return headerView
    }()
    
    fileprivate lazy var gameView : RecommendGameView = {
       let gameView = RecommendGameView.recommendGameView()
        gameView.frame = CGRect(x: 0, y: -kGameViewH, width: kScreenW, height: kGameViewH)
        return gameView
    }()
    //MARK: 系统回调
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadData()
        
        
    }

}

//MARK:- 设置UI界面
extension GameViewController{
    fileprivate func setupUI(){
        view.addSubview(collectionView)
        
        collectionView.addSubview(topHeaderView)
        
        collectionView.addSubview(gameView)
        
        //设置collectionView的内边距
        collectionView.contentInset = UIEdgeInsets(top: kHeaderViewH+kGameViewH, left: 0, bottom: 0, right: 0)
    }
}

//MARK:- 请求数据
extension GameViewController{
    fileprivate func loadData(){
        gameVM.loadAllGameData {
            //1.展示全部游戏
            self.collectionView.reloadData()
            //展示常用游戏
            self.gameView.groups = Array(self.gameVM.games[0..<10])
        }
    }
}
extension GameViewController : UICollectionViewDataSource{
    func  collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameVM.games.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellID, for: indexPath)  as! CollectionGameCell
        cell.baseGame = gameVM.games[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath) as! CollectionHeaderView
        headerView.titleLabel.text = "全部"
        headerView.iconImageView.image = UIImage(named: "Img_orange")
        headerView.moreBtn.isHidden = true
        headerView.moreBtn.backgroundColor = UIColor.blue
        return headerView
    }
}


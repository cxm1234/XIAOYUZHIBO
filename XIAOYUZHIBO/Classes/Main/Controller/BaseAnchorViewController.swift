//
//  BaseAnchorViewController.swift
//  XIAOYUZHIBO
//
//  Created by xiaoming on 16/10/21.
//  Copyright © 2016年 xiaoming. All rights reserved.
//

import UIKit
private let kItemMargin : CGFloat = 10
private let kHeaderViewH : CGFloat = 50

private let kNormalCellID = "kNormalCellID"
private let kHeaderViewID = "kHeaderViewID"

let kNormalItemW = (kScreenW - 3 * kItemMargin)/2
let kPrettyCellID = "kPrettyCellID"
let kNormalItemH = kNormalItemW * 3 / 4
let kPrettyItemH = kNormalItemW * 4 / 3

class BaseAnchorViewController: BaseViewController {

    //MARK:- 定义属性
    var baseVM : BaseViewModel!
    
    lazy var collectionView : UICollectionView = { [unowned self] in
        //创建布局
        let layout = UICollectionViewFlowLayout()
        
        layout.itemSize = CGSize(width: kNormalItemW, height: kNormalItemH)
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        
        
        loadData()
        // Do any additional setup after loading the view.
    }

}

extension BaseAnchorViewController{
    override func setupUI(){
        //给父类中内容的view
        contentView = collectionView
        view.addSubview(collectionView)
        super.setupUI()
    }
}



extension BaseAnchorViewController : UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return baseVM.anchorGroups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return baseVM.anchorGroups[section].anchors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //取出cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! CollectionNomalCell
        
        cell.anchor = baseVM.anchorGroups[indexPath.section].anchors[indexPath.item]
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath) as! CollectionHeaderView
        headerView.group = baseVM.anchorGroups[indexPath.section]
        return headerView
    }
    
    
}

extension BaseAnchorViewController : UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        print("点击了:\(indexPath)")
        let anchor = baseVM.anchorGroups[indexPath.section].anchors[indexPath.item]
        //判断是秀场房间还是普通房间
        anchor.isVertical == 0 ? pushNormalRoomVc() : presentShowRoomVc()
    }
    
    private func presentShowRoomVc(){
        //1.创建ShowRoomVc 
        let showRoomVc = RoomShowViewController()
        present(showRoomVc, animated: true,completion: nil)
    }
    
    private func pushNormalRoomVc(){
        let normalRoomVc = RoomNormalViewController()
        
        //以push的方式弹出
        navigationController?.pushViewController(normalRoomVc, animated: true)
    }
}

extension BaseAnchorViewController{
    func loadData(){
    }
}

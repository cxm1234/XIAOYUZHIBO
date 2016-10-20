//
//  AmuseViewController.swift
//  XIAOYUZHIBO
//
//  Created by xiaoming on 16/10/20.
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

class AmuseViewController: UIViewController {
    
    fileprivate lazy var amuseVM : AmuseViewModel = AmuseViewModel()

    //MARK :
    fileprivate lazy var collectionView : UICollectionView = { [unowned self] in
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
    //MARK: 系统回调
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        setupUI()
    }
}

extension AmuseViewController{
    fileprivate func setupUI(){
        view.addSubview(collectionView)
    }
}

//MARK:-请求数据
extension AmuseViewController{
    fileprivate func loadData(){
        amuseVM.loadAmuseData {
            self.collectionView.reloadData()
        }
    }
}

//MARK:- 

extension AmuseViewController : UICollectionViewDelegate,UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        let num : Int = amuseVM.anchorGroups.count
        print("一共有\(num)组")
        return num
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return amuseVM.anchorGroups[section].anchors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //取出cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! CollectionNomalCell
        
        cell.anchor = amuseVM.anchorGroups[indexPath.section].anchors[indexPath.item]
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath) as! CollectionHeaderView
        headerView.group = amuseVM.anchorGroups[indexPath.section]
        return headerView
    }
}

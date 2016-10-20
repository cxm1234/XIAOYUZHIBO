//
//  PageTitleView.swift
//  XIAOYUZB
//
//  Created by xiaoming on 16/9/18.
//  Copyright © 2016年 xiaoming. All rights reserved.
//

import UIKit

protocol PageTitleViewDelegate : class {
    func pageTitleView(_ titleView : PageTitleView,selectedIndex index : Int)
}


class PageTitleView: UIView {
    
    let kScrollLineH : CGFloat = 2
    
    let kNormalColor : (CGFloat, CGFloat, CGFloat) = (85,85,85)
    
    let kSelectColor : (CGFloat, CGFloat, CGFloat) = (255,128,0)
    
    
    var currentIndex : Int = 0
    var titles:[String]
    
    weak var delegate : PageTitleViewDelegate?
    
    lazy var titleLabels : [UILabel] = [UILabel]()
    
    lazy var scrollView:UIScrollView={
        let scrollView=UIScrollView()
        scrollView.showsHorizontalScrollIndicator=false
        scrollView.scrollsToTop=false
        scrollView.bounces=false
        return scrollView
    }()
    
    lazy var scrollLine : UIView = {
        let scrollLine = UIView()
//        scrollLine.backgroundColor = UIColor.orange
        return scrollLine
    }()
    
    // MARK:- 自定义构造函数
    init(frame:CGRect,titles:[String]){
        self.titles=titles
        
        super.init(frame:frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}


extension PageTitleView{
     func setupUI(){
        //1.添加UIScrollView
        addSubview(scrollView)
        scrollView.frame=bounds
//        scrollView.backgroundColor=UIColor.blue
        setupTitleLabels()
        setupBottomLineAndScrollLine()
    }

     func setupTitleLabels(){
        let labelW : CGFloat = frame.width / CGFloat(titles.count)
        print(labelW)
        let labelH : CGFloat = frame.height - kScrollLineH
        let labelY : CGFloat = 0
        for (index,title) in titles.enumerated() {
            let label = UILabel()
//            label.backgroundColor=UIColor.green
            label.text=title
            label.tag=index
            label.font=UIFont.systemFont(ofSize: 16.0)
            label.textColor=UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
            label.textAlignment = .center
            let labelX : CGFloat = labelW * CGFloat(index)
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            scrollView.addSubview(label)
            titleLabels.append(label)
            label.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(titleLabelClick(_:)))
            label.addGestureRecognizer(tapGes)
        }
    }
    
     func setupBottomLineAndScrollLine(){
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGray
        let lineH : CGFloat = 0.5
        bottomLine.frame = CGRect(x: 0, y: frame.height-lineH, width: frame.width, height: lineH)
        addSubview(bottomLine)
        //添加scrollLine
        //获取第一个label
        guard let firstLabel = titleLabels.first else { return }
        firstLabel.textColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
        scrollView.addSubview(firstLabel)
    }
}


extension PageTitleView{
      func titleLabelClick(_ tapGes : UITapGestureRecognizer){
        
        
        //获取当前Label的下标值
        guard let currentLabel = tapGes.view as? UILabel else { return }
        
        if currentLabel.tag == currentIndex {
            return
        }
        
        
        let oldLabel = titleLabels[currentIndex]
        currentLabel.textColor = UIColor.orange
        oldLabel.textColor = UIColor.darkGray
        currentIndex = currentLabel.tag
        let scrollLineX = CGFloat(currentLabel.tag) * currentLabel.frame.size.width
        UIView.animate(withDuration: 0.15) { 
            self.scrollLine.frame.origin.x=scrollLineX
        }
        delegate?.pageTitleView(self, selectedIndex: currentIndex)
    }
}

extension PageTitleView{
    func setTitleWithProgress(_ progress : CGFloat,sourceIndex : Int,targetIndex : Int){
        //1.取出sourceLabel/targetLabel
        let sourceLabel = titleLabels[sourceIndex]
        let targetLabel = titleLabels[targetIndex]
        
        //2.处理滑块逻辑
        let moveTotalX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        let moveX = moveTotalX * progress
        
        scrollLine.frame.origin.x = sourceLabel.frame.origin.x + moveX
        
        let colorDelta = (kSelectColor.0 - kNormalColor.0,kSelectColor.1 - kNormalColor.1,kSelectColor.2 - kNormalColor.2)
        
        sourceLabel.textColor = UIColor(r: kSelectColor.0 - colorDelta.0 * progress, g: kSelectColor.1 - colorDelta.1 * progress, b: kSelectColor.2 - colorDelta.2 * progress)
        
        
        targetLabel.textColor = UIColor(r: kNormalColor.0 - kSelectColor.0, g: kNormalColor.1 - kSelectColor.1, b: kNormalColor.1 - kSelectColor.1)
        
        
        currentIndex = targetIndex
    }
}


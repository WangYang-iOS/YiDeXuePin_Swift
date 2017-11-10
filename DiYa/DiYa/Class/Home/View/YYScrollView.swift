//
//  YYScrollView.swift
//  DiYa
//
//  Created by wangyang on 2017/11/10.
//  Copyright © 2017年 wangyang. All rights reserved.
//

import UIKit

let ITEM_WIDTH:CGFloat = SCREEN_WIDTH / 2.5

class YYScrollView: UIScrollView {

    var goodsList : [GoodsModel]? {
        didSet{
            //
            guard let array = goodsList else {
                return
            }
            for (index,subView) in subviews.enumerated() {
                //
                if subView.isMember(of: GoodsItem.self) {
                    if array.count > index {
                        subView.isHidden = false
                        let item = subView as! GoodsItem
                        moreButton.frame = CGRect(x: item.frame.origin.x + item.bounds.width, y: 0, width: 50, height: bounds.height)
                        item.goodsModel = array[index]
                    }else {
                        subView.isHidden = true
                    }
                    contentOffset = CGPoint(x: CGFloat(array.count)*ITEM_WIDTH + CGFloat(50), y: 0)
                }
            }
        }
    }
    
    var moreButton = UIButton(title: "查看更多", fontSize: 14, normalColor: UIColor.hexString(colorString: "777777"), highLightColor: UIColor.hexString(colorString: "777777"), imageName: "ic_loadAll")
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUI()
    }
    
}

extension YYScrollView {
    fileprivate func setUI() {
        for i in 0..<9 {
            
            let X = ITEM_WIDTH * CGFloat(i)
            let item = GoodsItem.loadNib()
            item.frame = CGRect(x: X, y: 0, width: ITEM_WIDTH, height: bounds.width)
            item.tag = 100 + i
            addSubview(item)
        }
        let view = subviews.last as! GoodsItem
        moreButton.frame = CGRect(x: view.frame.origin.x + view.bounds.width, y: 0, width: 50, height: bounds.height)
        moreButton.titleLabel?.numberOfLines = 0;
        moreButton.titleLabel?.lineBreakMode = .byWordWrapping
        addSubview(moreButton)
    }
}

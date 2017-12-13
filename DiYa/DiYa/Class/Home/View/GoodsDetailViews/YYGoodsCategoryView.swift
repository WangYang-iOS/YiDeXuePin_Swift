//
//  YYGoodsCategoryView.swift
//  DiYa
//
//  Created by wangyang on 2017/12/13.
//  Copyright © 2017年 wangyang. All rights reserved.
//

import UIKit

class YYGoodsCategoryView: UIView {
    
    var lastViewHeight : CGFloat = 44.0
    var skuCategoryList : [SkuCategoryModel]? {
        didSet {
            guard let skuCategoryList = skuCategoryList else {
                return
            }
            for (i,model) in skuCategoryList.enumerated() {
                let goodsSingleView = YYGoodsSingleView()
                goodsSingleView.skuCategoryModel = model
                let singleViewHeight = goodsSingleView.contentLabel.frame.size.height + CGFloat(24)
                goodsSingleView.frame = CGRect(x: 0, y: lastViewHeight, width: SCREEN_WIDTH, height: singleViewHeight)
                lastViewHeight = singleViewHeight + lastViewHeight
                if i % 2 == 0 {
                    goodsSingleView.backgroundColor = UIColor.hexString(colorString: "f2f2f2")
                }else {
                    goodsSingleView.backgroundColor = UIColor.hexString(colorString: "ffffff")
                }
                self.addSubview(goodsSingleView)
            }
            self.frame.size.height = lastViewHeight
        }
    }
    
}

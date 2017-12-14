//
//  YYGoodsSingleView.swift
//  DiYa
//
//  Created by wangyang on 2017/12/13.
//  Copyright © 2017年 wangyang. All rights reserved.
//

import UIKit

class YYGoodsSingleView: UIView {
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var contentLabel: UILabel!
    //    lazy var titleLabel : UILabel = {
//        let label = UILabel(frame: CGRect(x: 15, y: 12, width: 20, height: 12))
//        label.font = UIFont.systemFont(ofSize: 12)
//        label.textColor = UIColor.hexString(colorString: "999999")
//        return label
//    }()
//    
//    lazy var contentLabel : UILabel = {
//        let label = UILabel(frame: CGRect(x: titleLabel.frame.origin.x + titleLabel.frame.size.width + 22, y: 12, width: 20, height: 12))
//        label.font = UIFont.systemFont(ofSize: 12)
//        label.textColor = UIColor.hexString(colorString: "666666")
//        label.numberOfLines = 0
//        return label
//    }()

    var skuCategoryModel : SkuCategoryModel? {
        didSet {
            guard let skuCategoryModel = skuCategoryModel else {
                return
            }
            titleLabel.text = skuCategoryModel.name
            contentLabel.text = skuCategoryModel.value
            self.setNeedsLayout()
            self.layoutIfNeeded()
//            titleLabel.sizeToFit()
//            let size = contentLabel.sizeThatFits(CGSize(width: SCREEN_WIDTH - titleLabel.frame.size.width - 30 - 22, height: CGFloat(CGFloat.greatestFiniteMagnitude)))
//            contentLabel.frame = CGRect(x: titleLabel.frame.origin.x + titleLabel.frame.size.width + 22, y: 12, width: size.width, height: size.height)
        }
    }
    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        addSubview(titleLabel)
//        addSubview(contentLabel)
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
}

//
//  YYGoodsSingleView.swift
//  DiYa
//
//  Created by wangyang on 2017/12/13.
//  Copyright © 2017年 wangyang. All rights reserved.
//

import UIKit

class YYGoodsSingleView: UIView {
    
    lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.hexString(colorString: "999999")
        return label
    }()
    
    lazy var contentLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.hexString(colorString: "666666")
        label.numberOfLines = 0
        return label
    }()

    var skuCategoryModel : SkuCategoryModel? {
        didSet {
            guard let skuCategoryModel = skuCategoryModel else {
                return
            }
            titleLabel.text = skuCategoryModel.name
            contentLabel.text = skuCategoryModel.value
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLabel)
        addSubview(contentLabel)
        titleLabel.mas_makeConstraints { (make) in
            make?.left.equalTo()(15)
            make?.top.equalTo()(12)
        }
        contentLabel.mas_makeConstraints { (make) in
            make?.left.equalTo()(self.titleLabel.mas_right)?.offset()(22)
            make?.top.equalTo()(12)
            make?.right.equalTo()(-15)
        }
        self.layoutIfNeeded()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

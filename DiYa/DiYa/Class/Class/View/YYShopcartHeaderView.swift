//
//  YYShopcartHeaderView.swift
//  DiYa
//
//  Created by wangyang on 2017/12/15.
//  Copyright © 2017年 wangyang. All rights reserved.
//

import UIKit

@objc protocol YYShopcartHeaderViewDelegate {
    @objc optional
    func didSelectedCategory(categoryId:String)
    func didClickCategory(shopcartModel:ShopcartModel)
}

class YYShopcartHeaderView: UIView {
    @IBOutlet weak var selectedButton: UIButton!
    @IBOutlet weak var titleButton: UIButton!
    weak var delegate : YYShopcartHeaderViewDelegate?
    var shopCarModel : ShopcartModel? {
        didSet {
            guard let shopCarModel = shopCarModel else {
                return
            }
            selectedButton.isSelected = shopCarModel.isSelected
            titleButton.setTitle(shopCarModel.categoryName, for: [])
            guard
            let imgWidth = titleButton.imageView?.frame.size.width,
            let titleWidth = titleButton.titleLabel?.intrinsicContentSize.width else {
                    return
            }
            let space : CGFloat = 5
            titleButton.imageEdgeInsets = UIEdgeInsetsMake(0, titleWidth + space/2.0, 0, -titleWidth-space/2.0)
            titleButton.titleEdgeInsets = UIEdgeInsetsMake(0, -(imgWidth + space/2.0), 0, imgWidth+space/2.0)
        }
    }
    
    @IBAction func clickButton(_ sender: UIButton) {
        if sender == selectedButton {
            //选中
            guard let shopcartModel = shopCarModel else {
                return
            }
            delegate?.didClickCategory(shopcartModel: shopcartModel)
        }else {
            //查看分类
            delegate?.didSelectedCategory?(categoryId: shopCarModel?.categoryId ?? "")
        }
    }
}

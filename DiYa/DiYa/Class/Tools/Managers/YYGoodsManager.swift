//
//  YYGoodsManager.swift
//  DiYa
//
//  Created by wangyang on 2017/12/14.
//  Copyright © 2017年 wangyang. All rights reserved.
//

import UIKit

var _goodsSelectView : YYGoodsSkuView!
var _shadowView : UIView!

class YYGoodsManager: NSObject {
    static let shareManagre = YYGoodsManager()
    private override init() {}
}

extension YYGoodsManager {
    func showGoodsSelectView(goodsModel : GoodsModel, skuCategoryList:[SkuCategoryModel], goodsSkuList:[GoodsSkuModel]) {
        let window = (UIApplication.shared.delegate as! AppDelegate).window
        _shadowView = UIView()
        _shadowView.frame = RECT(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT)
        _shadowView.backgroundColor = UIColor.hexString(colorString: "000000", alpha: 0.3)
        window?.addSubview(_shadowView)
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(hiddenSelectView))
        _shadowView.addGestureRecognizer(tap)
        
        _goodsSelectView = YYGoodsSkuView.loadXib1() as! YYGoodsSkuView
        window?.addSubview(_goodsSelectView)
        _goodsSelectView.goodsModel = goodsModel
        _goodsSelectView.skuList = skuCategoryList
        _goodsSelectView.goodsSkuList = goodsSkuList
        _goodsSelectView.frame = RECT(x: 0, y: SCREEN_HEIGHT, width: SCREEN_WIDTH, height: _goodsSelectView.goodsSkuViewHieght)
        
        UIView.animate(withDuration: 0.25) {
            _goodsSelectView.frame = RECT(x: 0, y: SCREEN_HEIGHT - _goodsSelectView.goodsSkuViewHieght, width: SCREEN_WIDTH, height: _goodsSelectView.goodsSkuViewHieght)
        }
    }
    
    @objc func hiddenSelectView() {
        _shadowView.removeFromSuperview()
        UIView.animate(withDuration: 0.25, animations: {
            _goodsSelectView.frame = RECT(x: 0, y: SCREEN_HEIGHT, width: SCREEN_WIDTH, height: _goodsSelectView.goodsSkuViewHieght)
        }) { (finish) in
            _goodsSelectView.removeFromSuperview()
        }
    }
}

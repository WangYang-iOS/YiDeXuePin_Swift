//
//  YYGoodsSkuView.swift
//  DiYa
//
//  Created by wangyang on 2017/12/14.
//  Copyright © 2017年 wangyang. All rights reserved.
//

import UIKit

@objc protocol YYGoodsSkuViewDelegate {
    @objc optional
    func didSelectedGoodsWith(skuValue:String,number:Int)
}

class YYGoodsSkuView: UIView {
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var inventoryLabel: UILabel!
    @IBOutlet weak var skuView: UIView!
    @IBOutlet weak var skuViewHeight: NSLayoutConstraint!
    @IBOutlet weak var changeNumberView: YYChangeNumberView!
    weak var delegate : YYGoodsSkuViewDelegate?
    var lastMaxY : CGFloat = 0
    var goodsSkuViewHieght : CGFloat = 0
    var dic = [Int:String]()
    var goodsSkuList = [GoodsSkuModel]()
    var goodsModel : GoodsModel? {
        didSet {
            guard let goodsModel = goodsModel else {
                return
            }
            priceLabel.text = "¥" + goodsModel.price
            inventoryLabel.text = "库存" + goodsModel.inventory + "件"
        }
    }
    
    var skuId = ""
    var skuValue = ""
    
    var skuList : [SkuCategoryModel]? {
        didSet {
            guard let skuList = skuList else {
                return
            }
            for (i,model) in skuList.enumerated() {
                let skuSingleView = YYSkuView.loadXib1() as! YYSkuView
                skuSingleView.delegate = self
                skuSingleView.tag = 10 + i
                skuView.addSubview(skuSingleView)
                skuSingleView.skuModel = model
                lastMaxY = skuSingleView.lastMaxY + lastMaxY
            }
            skuViewHeight.constant = lastMaxY
            self.layoutIfNeeded()
            goodsSkuViewHieght = skuView.frame.origin.y + skuView.frame.size.height + CGFloat(54 + 84)
        }
    }
    @IBAction func clickButton(_ sender: UIButton) {
        if sender.tag == 1000 {
            //取消
            YYGoodsManager.shareManagre.hiddenSelectView()
        }else {
            //确定
            delegate?.didSelectedGoodsWith?(skuValue: skuValue, number: changeNumberView.number)
        }
    }
}

extension YYGoodsSkuView : YYSkuViewDelegate {
    func didSelectedItem(skuView: YYSkuView, title: String) {
        dic[skuView.tag - 10] = title
        guard
            let skuList = skuList else {
            return
        }
        //如果选择的规格和规格数组的元素数量相同，则改变库存和价格
        if dic.count == skuList.count {
            //
            let dictionary = dic.sorted(by: { (t1, t2) -> Bool in
                return t1.0 < t2.0 ? true : false
            })
            
            for (key,value) in dictionary {
                print(key,value)
                skuValue = skuValue + "," + value
            }
            skuValue = (skuValue as NSString).substring(from: 1)
            
            for (_,model) in goodsSkuList.enumerated() {
                if skuValue == model.skuValue {
                    skuId = model.id
                    priceLabel.text = "¥" + model.discountPrice
                    inventoryLabel.text = "库存" + model.inventory + "件"
                    break
                }else {
                    priceLabel.text = "¥" + model.price
                    inventoryLabel.text = "库存" + "0" + "件"
                }
            }
        }
    }
}

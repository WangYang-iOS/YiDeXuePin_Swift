//
//  YYSkuView.swift
//  DiYa
//
//  Created by wangyang on 2017/12/14.
//  Copyright © 2017年 wangyang. All rights reserved.
//

import UIKit

@objc protocol YYSkuViewDelegate {
    @objc optional
    func didSelectedItem(skuView : YYSkuView, title : String)
}

class YYSkuView: UIView {

    @IBOutlet weak var skuLabel:UILabel!
    fileprivate var lastLabel = UILabel()
    
    weak var delegate : YYSkuViewDelegate?
    
    var lastMaxY : CGFloat = 0
    var skuModel : SkuCategoryModel? {
        didSet {
            guard let skuModel = skuModel else {
                return
            }
            skuLabel.text = skuModel.name
            self.layoutIfNeeded()
            layoutSkuView(model: skuModel)
        }
    }
    
}

extension YYSkuView {
    fileprivate func layoutSkuView(model : SkuCategoryModel) {
        //
        let array = model.value.components(separatedBy: ",")
        let beginX = skuLabel.frame.origin.x + skuLabel.frame.size.width + CGFloat(15)
        let maxWidth = SCREEN_WIDTH - beginX - CGFloat(15)
        let margin : CGFloat = 15
        var lastMaxX : CGFloat = 0
        var labelWidth : CGFloat = 0
        
        var X : CGFloat = 0
        var Y : CGFloat = 0
        
        for (i,value) in array.enumerated() {
            labelWidth = ((value as NSString).size(withAttributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 12)])).width + CGFloat(28)
            //判断下一个生成的Label的宽度 + 上一次Label的最大X值 是否大于 最大宽度 ，如果大于 换行，否则继续在这行创建
            if (lastMaxX + labelWidth) < maxWidth {
                //不换行
                if lastMaxX == CGFloat(0) {
                    //第一个label
                    X = beginX
                    lastMaxX = beginX + labelWidth
                    lastMaxY = lastMaxY + margin + CGFloat(24)
                }else {
                    X = lastMaxX + margin
                    Y = lastMaxY - margin - CGFloat(24)
                    lastMaxX = lastMaxX + margin + labelWidth
                }
            }else {
                //换行
                Y = lastMaxY
                X = beginX
                lastMaxY = lastMaxY + margin + CGFloat(24)
                lastMaxX = beginX + labelWidth
            }
            print("x:\(X) Y:\(Y) labelWidth:\(labelWidth)")
            let label = UILabel(frame: RECT(x: X, y: Y, width: labelWidth, height: 24))
            label.backgroundColor = UIColor.hexString(colorString: "f2f2f2")
            label.font = UIFont.systemFont(ofSize: 12)
            label.textColor = UIColor.hexString(colorString: "666666")
            label.text = value
            label.textAlignment = .center
            label.layer.cornerRadius = 12.0
            label.layer.masksToBounds = true
            label.isUserInteractionEnabled = true
            label.tag = 100 + i
            addSubview(label)
            let tap = UITapGestureRecognizer.init(target: self, action: #selector(tapLabel))
            label.addGestureRecognizer(tap)
        }
    }
    
    @objc func tapLabel(tap:UITapGestureRecognizer) {
        //
        let label = tap.view as! UILabel
        if lastLabel == label {
            return
        }
        guard let array = skuModel?.value.components(separatedBy: ",") else {
            return
        }
        label.backgroundColor = UIColor.hexString(colorString: "c2001a")
        label.textColor = UIColor.white
        lastLabel.backgroundColor = UIColor.hexString(colorString: "f2f2f2")
        lastLabel.textColor = UIColor.hexString(colorString: "666666")
        lastLabel = label
        delegate?.didSelectedItem?(skuView: self, title: array[label.tag - 100])
    }
}

//
//  GoodsItem.swift
//  DiYa
//
//  Created by wangyang on 2017/11/10.
//  Copyright © 2017年 wangyang. All rights reserved.
//

import UIKit
import YYWebImage

class GoodsItem: UIView {
    
    @IBOutlet weak var imageHeight: NSLayoutConstraint!
    @IBOutlet weak var imageWidth: NSLayoutConstraint!
    
    @IBOutlet weak var goodsImageView: UIImageView!
    @IBOutlet weak var goodsTitleLable: UILabel!
    @IBOutlet weak var discountLabel: UILabel!
    @IBOutlet weak var marketLabel: UILabel!
    
    var goodsModel:GoodsModel? {
        didSet{
            //
//            goodsImageView.sd_setImage(with: URL(string: goodsModel?.picture ?? ""), placeholderImage: UIImage(named: "ic_home_logo"))
            goodsImageView.yy_setImage(with: URL(string: goodsModel?.picture ?? ""), placeholder: UIImage(named: "ic_home_logo"))
            goodsTitleLable.text = goodsModel?.title
            discountLabel.text = "¥" + "\(goodsModel?.price ?? "")"
            marketLabel.text = "¥" + "\(goodsModel?.marketPrice ?? "")"
            let attributedStr = NSMutableAttributedString(string: marketLabel.text!)
            attributedStr.addAttribute(.strikethroughStyle, value: NSNumber(value:1), range: NSMakeRange(0,attributedStr.length))
            marketLabel.attributedText = attributedStr
        }
    }
    
    class func loadNib() -> GoodsItem {
        //
        let nib = UINib.init(nibName: "GoodsItem", bundle: nil)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! GoodsItem
        return view
    }
    
    func loadImage(imgUrl:String) {
        goodsImageView.yy_setImage(with: URL(string: imgUrl), placeholder: UIImage(named: "ic_home_logo"))
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageWidth.constant = 88*HEIGHT_MULTIPLE
        imageHeight.constant = 88*HEIGHT_MULTIPLE*Goods_MULTIPLE
    }

}

//
//  YYEditShopCartCell.swift
//  DiYa
//
//  Created by wangyang on 2017/12/18.
//  Copyright © 2017年 wangyang. All rights reserved.
//

import UIKit

@objc protocol YYEditShopCartCellDelegate {
    @objc optional
    func didSelectedGoods(goodsModel : GoodsModel)
    func didSelectedCategory(goodsModel : GoodsModel)
}

class YYEditShopCartCell: UITableViewCell {
    @IBOutlet weak var selectedButton: UIButton!
    @IBOutlet weak var goodsImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    weak var delegate : YYEditShopCartCellDelegate?
    var number : Int = 0 {
        didSet {
            numberLabel.text = "\(number)"
        }
    }
    
    
    var goodsModel : GoodsModel? {
        didSet {
            guard let goodsModel = goodsModel else {
                return
            }
            selectedButton.isSelected = goodsModel.isSelected
            goodsImageView.sd_setImage(with: URL(string: goodsModel.picture), placeholderImage: UIImage(named: "ic_home_logo"))
            titleLabel.text = goodsModel.title
            categoryLabel.text = goodsModel.skuValue
            number = Int(goodsModel.number) ?? 0
        }
    }
    
    
    @IBAction func clickSelectedButton(_ sender: UIButton) {
        guard let goodsModel = goodsModel else {
            return
        }
        delegate?.didSelectedGoods?(goodsModel: goodsModel)
    }
    
    @IBAction func clickCategoryButton(_ sender: UIButton) {
        //选择分类
        guard let goodsModel = goodsModel else {
            return
        }
        delegate?.didSelectedCategory(goodsModel: goodsModel)
    }
    
    @IBAction func clickNumberButton(_ sender: UIButton) {
        if sender.tag == 100 {
            //-
            if number == 0 {
                return
            }
            number = number - 1;
        }else {
            //+
            number = number + 1;
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

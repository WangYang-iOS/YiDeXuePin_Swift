//
//  YYShopcartCell.swift
//  DiYa
//
//  Created by wangyang on 2017/12/15.
//  Copyright © 2017年 wangyang. All rights reserved.
//

import UIKit

class YYShopcartCell: UITableViewCell {
    @IBOutlet weak var selectedButton: UIButton!
    @IBOutlet weak var goodsImageView: UIImageView!
    @IBOutlet weak var goodsTitleLabel: UILabel!
    @IBOutlet weak var skuLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    
    var goodsModel : GoodsModel? {
        didSet {
            guard let goodsModel = goodsModel else {
                return
            }
            selectedButton.isSelected = goodsModel.isSelected
            goodsImageView.sd_setImage(with: URL(string: goodsModel.picture), placeholderImage: UIImage(named: "ic_home_logo"))
            goodsTitleLabel.text = goodsModel.title
            skuLabel.text = goodsModel.skuValue
            priceLabel.text = "¥" + goodsModel.discountPrice
            numberLabel.text = "x"+goodsModel.number
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func clickSelectButton(_ sender: UIButton) {
        
    }
}

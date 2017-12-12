//
//  YYAllClassViewCell.swift
//  DiYa
//
//  Created by wangyang on 2017/12/12.
//  Copyright © 2017年 wangyang. All rights reserved.
//

import UIKit

class YYAllClassViewCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel?
    
    var model : GoodsModel? {
        didSet {
            guard let model = model else {
                return
            }
            titleLabel?.text = model.name
            print(model.isSelected)
            if model.isSelected {
                layer.borderWidth = 1;
                layer.borderColor = UIColor.hexString(colorString: "c4000e").cgColor;
            }else {
                self.layer.borderWidth = 0;
                self.layer.borderColor = UIColor.hexString(colorString:"b5b5b5").cgColor;
            }
            titleLabel?.textColor = model.isSelected ? UIColor.hexString(colorString: "ffffff") : UIColor.hexString(colorString: "666666")
            titleLabel?.backgroundColor = model.isSelected ? UIColor.hexString(colorString: "c4000e") : UIColor.hexString(colorString: "f7f6f5")
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}

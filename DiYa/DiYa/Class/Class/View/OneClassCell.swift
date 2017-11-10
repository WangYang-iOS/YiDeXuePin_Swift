//
//  OneClassCell.swift
//  DiYa
//
//  Created by wangyang on 2017/11/10.
//  Copyright © 2017年 wangyang. All rights reserved.
//

import UIKit

class OneClassCell: UITableViewCell {

    @IBOutlet weak var classLabel: UILabel!
    
    var categoryModelList:CategoryModelList? {
        didSet {
            classLabel.text = categoryModelList?.name
            if categoryModelList?.isSelected == true {
                self.backgroundColor = UIColor.white
                classLabel.textColor = UIColor.hexString(colorString: "4d4d4d")
                classLabel.font = UIFont.systemFont(ofSize: 13.5)
            }else {
                self.backgroundColor = UIColor.hexString(colorString: "fafafa")
                classLabel.textColor = UIColor.hexString(colorString: "787878")
                classLabel.font = UIFont.systemFont(ofSize: 12.5)
            }
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
    
}

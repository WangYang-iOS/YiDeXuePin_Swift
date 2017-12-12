//
//  YYAllClassReusableView.swift
//  DiYa
//
//  Created by wangyang on 2017/12/12.
//  Copyright © 2017年 wangyang. All rights reserved.
//

import UIKit

class YYAllClassReusableView: UICollectionReusableView {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var openButton: UIButton!
    var hiddenClassBlock : (()->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBAction func hiddenClassView(_ sender: UIButton) {
        if (hiddenClassBlock != nil) {
            hiddenClassBlock?()
        }
    }
    
}

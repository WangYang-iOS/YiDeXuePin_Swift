//
//  YYChangeNumberView.swift
//  DiYa
//
//  Created by wangyang on 2017/12/14.
//  Copyright © 2017年 wangyang. All rights reserved.
//

import UIKit

class YYChangeNumberView: UIView {

    @IBOutlet weak var numberLabel : UILabel!
    
    var number : Int = 0 {
        didSet {
            numberLabel.text = String(number)
        }
    }
    
    @IBAction func addNumber() {
        number += 1
    }
    @IBAction func deleteNumber() {
        if number == 0 {
            return
        }
        number -= 1
    }
}

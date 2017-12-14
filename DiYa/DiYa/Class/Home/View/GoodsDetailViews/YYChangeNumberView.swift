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
    
    var number : Int? {
        didSet {
            guard let number = number else {
                return
            }
            numberLabel.text = String(number)
        }
    }
    
    @IBAction func addNumber() {
        guard var number = number else {
            return
        }
        number += 1;
    }
    @IBAction func deleteNumber() {
        guard var number = number else {
            return
        }
        if number == 0 {
            return
        }
        number -= 1;
    }
}

//
//  WYExtensions.swift
//  DiYa
//
//  Created by wangyang on 2017/9/26.
//  Copyright © 2017年 wangyang. All rights reserved.
//

import UIKit

extension UIColor {
    class func hexString(colorString:String ,alpha:CGFloat = 1.0) -> UIColor {
        var string = colorString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        if string.characters.count < 6 {
            return UIColor.clear
        }
        if string.hasPrefix("0X") {
            string = string.substring(from: string.index(string.startIndex, offsetBy: 2))
        }
        if string.hasPrefix("#") {
            string = string.substring(from: string.index(after: string.startIndex))
        }
        if string.characters.count != 6 {
            return UIColor.clear
        }
        
        let rRange = string.startIndex ..< string.index(string.startIndex, offsetBy: 2)
        let rStr = string.substring(with: rRange)
        
        let gRange = string.index(string.startIndex, offsetBy: 2) ..< string.index(string.startIndex, offsetBy: 4)
        let gStr = string.substring(with: gRange)
        
        let bIndex = string.index(string.endIndex, offsetBy: -2)
        let bStr = string.substring(from: bIndex)
        
        var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
        Scanner(string: rStr).scanHexInt32(&r)
        Scanner(string: gStr).scanHexInt32(&g)
        Scanner(string: bStr).scanHexInt32(&b)
        
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: alpha)
    }
}

extension UIButton {
    class  func wy_createButton(title:String,fontSize:CGFloat,normalColor:UIColor,highLightColor:UIColor,imageName:String) -> UIButton {
        let button = UIButton(type: .custom)
        button.titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
        button.setTitle(title, for: .normal)
        button.setTitleColor(normalColor, for: .normal)
        button.setTitleColor(highLightColor, for: .highlighted)
        button.setImage(UIImage.init(named: imageName), for: .normal)
        button.sizeToFit()
        return button
    }
    
    convenience init(title:String,fontSize:CGFloat,normalColor:UIColor,highLightColor:UIColor,imageName:String) {
        self.init()
        titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
        setTitle(title, for: .normal)
        setTitleColor(normalColor, for: .normal)
        setTitleColor(highLightColor, for: .highlighted)
        setImage(UIImage.init(named: imageName), for: .normal)
    }
    
}

extension UILabel {
    class func wy_createLabel(title:String,fontSize:CGFloat,textColor:UIColor,alignment:NSTextAlignment = .left) -> UILabel {
        let label = UILabel()
        label.textColor = textColor
        label.text = title
        label.font = UIFont.systemFont(ofSize: fontSize)
        label.textAlignment = alignment
        label.sizeToFit()
        return label
    }
}

extension UIView {
    class func loadXib1() -> UIView {
        let spaceName = Bundle.main.infoDictionary?["CFBundleName"] as? String ?? ""
        var classStr = NSStringFromClass(self.classForCoder())
        classStr = classStr.substring(from: classStr.index(classStr.startIndex, offsetBy: spaceName.count + 1))
        let view = UINib.init(nibName: classStr, bundle: nil).instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }
}

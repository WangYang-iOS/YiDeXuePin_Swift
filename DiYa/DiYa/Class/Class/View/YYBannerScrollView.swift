//
//  YYBannerScrollView.swift
//  DiYa
//
//  Created by wangyang on 2017/12/11.
//  Copyright © 2017年 wangyang. All rights reserved.
//

import UIKit

let PADDING : CGFloat = (SCREEN_WIDTH - 70 * 4) / 5.0;

@objc protocol YYBannerScrollViewDelegate {
    @objc optional
    func bannerScrollViewclickIndex(index:Int)
    func openClassView()
}

class YYBannerScrollView: UIView {

    @IBOutlet weak var scrlloView: UIScrollView!
    weak var delegate : YYBannerScrollViewDelegate?
    var lastButton = UIButton()
    var lastSelectButton = UIButton()
    fileprivate lazy var lineLabel : UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.white
        return label
    }()
    
    var index : Int? {
        didSet {
            guard let index = index else {
                return
            }
            let button = self.viewWithTag(100 + index) as! UIButton
            clickButton(button: button)
        }
    }
    
    var titleArray : [String]? {
        didSet {
            guard let titleArray = titleArray else {
                return
            }
            
            //遍历子视图，如果有先移除再添加
            for subView in subviews {
                if subView.isKind(of: UIButton.classForCoder()) {
                    removeFromSuperview()
                }
            }
            
            for (i,_) in titleArray.enumerated() {
                addButton(index: i)
            }
        }
    }
    class func loadXib() -> YYBannerScrollView {
        let bannerView = UINib.init(nibName: "YYBannerScrollView", bundle: nil).instantiate(withOwner: self, options: nil)[0] as! YYBannerScrollView
        return bannerView
    }
    
    @IBAction func openClassList(_ sender: UIButton) {
        delegate?.openClassView()
    }
}

extension YYBannerScrollView {
    fileprivate func addButton(index : Int) {
        guard let titleArray = titleArray else {
            return
        }
        let button = UIButton.wy_createButton(title: titleArray[index], fontSize: 15, normalColor: UIColor.hexString(colorString: "ffffff", alpha: 0.5), highLightColor: UIColor.hexString(colorString: "ffffff"), imageName: "")
        button.bounds = CGRect(x: 0, y: 0, width: button.bounds.width + 4, height: button.bounds.width)
        button.frame.origin = CGPoint(x: PADDING + lastButton.frame.origin.x + lastButton.frame.size.width, y: 0)
        button.center = CGPoint(x: button.center.x, y: bounds.size.height / 2.0)
        button.setTitleColor(UIColor.hexString(colorString: "ffffff", alpha: 0.5), for:[])
        button.setTitleColor(UIColor.hexString(colorString: "ffffff"), for:.selected)
        button.addTarget(self, action: #selector(clickButton), for: .touchUpInside)
        button.tag = 100 + index;
        scrlloView.addSubview(button)
        lastButton = button
        if index == 0 {
            button.isSelected = true
            lastSelectButton = button
            scrlloView.addSubview(lineLabel)
            lineLabel.bounds = CGRect(x: 0, y: 0, width: button.frame.size.width, height: 2)
            lineLabel.center = CGPoint(x: button.center.x, y: scrlloView.frame.size.height - 1)
        }
        scrlloView.contentSize = CGSize(width: lastButton.frame.origin.x + lastButton.frame.size.width + PADDING, height: 45)
    }
    
    @objc func clickButton(button:UIButton) {
        lastSelectButton.isSelected = !lastSelectButton.isSelected
        button.isSelected = !button.isSelected
        UIView.animate(withDuration: 0.25, animations: {
            self.lineLabel.bounds = CGRect(x: 0, y: 0, width: button.frame.size.width, height: 2)
            self.lineLabel.center = CGPoint(x: button.center.x, y: self.scrlloView.frame.size.height - 1)
        }) { (finish) in
            let center_x = button.center.x
            let scrollView_width = self.scrlloView.frame.size.width
            let scrollView_contentWidth = self.scrlloView.contentSize.width
            if (center_x > scrollView_width/2.0) {
                if (scrollView_contentWidth - center_x < scrollView_width/2.0) {
                    self.scrlloView.setContentOffset(CGPoint(x: scrollView_contentWidth - scrollView_width, y: 0), animated: true)
                } else {
                    self.scrlloView.setContentOffset(CGPoint(x: center_x - scrollView_width / 2.0, y: 0), animated: true)
                }
            } else {
                self.scrlloView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
            }
        }
        lastSelectButton = button;
        delegate?.bannerScrollViewclickIndex?(index: button.tag - 100)
    }
}

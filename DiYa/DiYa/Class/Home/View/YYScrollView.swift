//
//  YYScrollView.swift
//  DiYa
//
//  Created by wangyang on 2017/11/10.
//  Copyright © 2017年 wangyang. All rights reserved.
//

import UIKit

let ITEM_WIDTH:CGFloat = SCREEN_WIDTH / 2.5

class YYScrollView: UIScrollView {

    var moreBlock : (() -> ())?
    
    var goodsList : [GoodsModel]? {
        didSet{
            //
            guard let array = goodsList else {
                return
            }
            contentOffset = CGPoint(x: 0, y: 0)
            for (index,subView) in subviews.enumerated() {
                //
                if subView.isMember(of: GoodsItem.self) {
                    let item = subView as! GoodsItem
                    item.frame.origin.y = 0
                    item.frame.size.height = bounds.height
                    if array.count > index {
                        item.isHidden = false
                        moreButton.frame = CGRect(x: item.frame.origin.x + item.bounds.width, y: 0, width: 50, height: bounds.height)
                        item.goodsModel = array[index]
                    }else {
                        item.isHidden = true
                    }
                    contentSize = CGSize(width: CGFloat(array.count)*ITEM_WIDTH + CGFloat(50), height: 0)
                }
            }
        }
    }
    
    var moreButton = UIButton(title: "查\n看\n更\n多", fontSize: 14, normalColor: UIColor.hexString(colorString: "777777"), highLightColor: UIColor.hexString(colorString: "777777"), imageName: "ic_loadAll")
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUI()
    }
    
    func loadImage(array:[GoodsModel]) {
        contentOffset = CGPoint(x: 0, y: 0)
        for (index,subView) in subviews.enumerated() {
            //
            if subView.isMember(of: GoodsItem.self) {
                let item = subView as! GoodsItem
                item.frame.origin.y = 0
                item.frame.size.height = bounds.height
                if array.count > index {
                    item.loadImage(imgUrl: array[index].picture)
                }else {
                    item.loadImage(imgUrl: "")
                }
            }
        }
    }
    
    @objc func tapItem(tap:UITapGestureRecognizer) {
        guard let item = tap.view as? GoodsItem,
            let goodsList = goodsList else {
            return
        }
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue:NSNotificationNameHomeGoodsClick), object: self, userInfo: ["model":goodsList[item.tag - 100]])
    }
    
    @objc func clickMore(button:UIButton) {
        if moreBlock != nil {
            moreBlock!()
        }
    }
}

extension YYScrollView {
    fileprivate func setUI() {
        for i in 0..<9 {
            let X = ITEM_WIDTH * CGFloat(i)
            let item = GoodsItem.loadNib()
            item.frame = CGRect(x: X, y: 0, width: ITEM_WIDTH, height: bounds.height)
            item.tag = 100 + i
            addSubview(item)
            let tap = UITapGestureRecognizer(target: self, action: #selector(tapItem))
            item.addGestureRecognizer(tap)
        }
        let view = subviews.last as! GoodsItem
        moreButton.frame = CGRect(x: view.frame.origin.x + view.bounds.width, y: 0, width: 50, height: bounds.height)
        moreButton.titleLabel?.numberOfLines = 0;
        moreButton.titleLabel?.lineBreakMode = .byWordWrapping
        addSubview(moreButton)
        moreButton.addTarget(self, action: #selector(clickMore), for: .touchUpInside)
    }
}

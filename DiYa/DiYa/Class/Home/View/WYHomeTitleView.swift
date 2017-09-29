//
//  WYHomeTitleView.swift
//  DiYa
//
//  Created by wangyang on 2017/9/28.
//  Copyright © 2017年 wangyang. All rights reserved.
//

import UIKit
import Masonry

class WYHomeTitleView: UIView {

    fileprivate lazy var messageButton :UIButton = {
        let messageButton = UIButton(type: .custom)
        messageButton.setImage(UIImage(named:"ic_home_noti_none"), for: .normal)
        return messageButton
    }()
    
    var clickSearchBlock : (() -> ())?
    
    override init(frame: CGRect) {
        //
        super.init(frame:frame)

        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc fileprivate func goToSearch() {
        //
        if clickSearchBlock != nil {
            clickSearchBlock!()
        }
    }
    
}

extension WYHomeTitleView {
    fileprivate func setupUI() {
        let logo = UIImageView(image: UIImage(named:"ic_home_logo"))
        addSubview(logo)
        
        logo.mas_makeConstraints { (make) in
            make?.left.equalTo()(self.mas_left)?.offset()(0)
            make?.centerY.equalTo()(self)
            make?.size.mas_equalTo()(CGSize(width: 18, height: 25))
        }
        
        addSubview(messageButton)
        messageButton.mas_makeConstraints { (make) in
            make?.right.equalTo()(self.mas_right)?.setOffset(0)
            make?.centerY.equalTo()(self)
            make?.size.mas_equalTo()(CGSize(width: 21.0, height: 18.5))
        }
        
        let button = UIButton(type: .custom)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.setBackgroundImage(UIImage(named:"ic_home_search"), for: .normal)
        button.setImage(UIImage(named:"ic_home_searchLogo"), for: .normal)
        button.setTitle("在此找您稀饭的宝贝", for: .normal)
        button.setTitleColor(UIColor.hexString(colorString: "f6cbcb"), for: .normal)
        button.addTarget(self, action: #selector(goToSearch), for: .touchUpInside)
        button.imageEdgeInsets = UIEdgeInsetsMake(0, -30, 0, 0)
        button.titleEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0)
        addSubview(button)

        button.mas_makeConstraints { (make) in
            make?.left.equalTo()(logo.mas_right)?.setOffset(15)
            make?.right.equalTo()(self.messageButton.mas_left)?.setOffset(-15)
            make?.centerY.equalTo()(self)
        }
        
        
    }
    
    func resetMessageButtonImage(haveMessage:Bool) {
        if haveMessage {
            messageButton.setImage(UIImage(named:"ic_home_noti"), for: .normal)
        }else {
            messageButton.setImage(UIImage(named:"ic_home_noti_none"), for: .normal)
        }
    }
}

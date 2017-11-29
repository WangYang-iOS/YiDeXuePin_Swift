//
//  YYClassListViewController.swift
//  DiYa
//
//  Created by wangyang on 2017/11/29.
//  Copyright © 2017年 wangyang. All rights reserved.
//

import UIKit

class YYClassListViewController: WYBaseViewController {

    var vcTitle:String?
    var categoryId : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
}

extension YYClassListViewController {
    func setUI() {
        navigationItem.title = vcTitle
        leftBarButton()
    }
}

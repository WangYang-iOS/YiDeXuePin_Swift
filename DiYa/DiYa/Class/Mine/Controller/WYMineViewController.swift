//
//  WYMineViewController.swift
//  DiYa
//
//  Created by wangyang on 2017/9/26.
//  Copyright © 2017年 wangyang. All rights reserved.
//

import UIKit

class WYMineViewController: WYBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationItem.title = "个人中心"
    }
    
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
        if !isLogin() {
            presentLoginVC(complete: nil)
        }
    }
}

extension WYMineViewController {
    func isLogin() -> Bool{
        guard let _ = WYCommomMethod.valueForKey(key: ACCESS_TOKEN) else {
            return false;
        }
        return true;
    }
}

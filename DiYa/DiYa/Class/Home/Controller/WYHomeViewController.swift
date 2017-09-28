//
//  WYHomeViewController.swift
//  DiYa
//
//  Created by wangyang on 2017/9/26.
//  Copyright © 2017年 wangyang. All rights reserved.
//

import UIKit

class WYHomeViewController: WYBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigation()
        
        if isLogin() == false {
            presentLoginVC(complete: {
                print("弹出登录界面")
            })
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


extension WYHomeViewController {
    fileprivate func setNavigation() {
        navigationItem.title = "首页"
        let customTitleView = WYHomeTitleView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 44))
        self.navigationItem.titleView = customTitleView
        customTitleView.clickSearchBlock = { ()->() in
            print("跳转到搜索界面")
        }
    }
    
    func isLogin() -> Bool {
        return false
    }
    
}

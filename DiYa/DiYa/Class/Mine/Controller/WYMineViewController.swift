//
//  WYMineViewController.swift
//  DiYa
//
//  Created by wangyang on 2017/9/26.
//  Copyright © 2017年 wangyang. All rights reserved.
//

import UIKit

class WYMineViewController: WYBaseViewController {

    @IBOutlet weak var headerImageVIew: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var signLabel: UILabel!
    
    fileprivate var navigitionHidden = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "个人中心"
    }
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: navigitionHidden)
        if !isLogin() {
            presentLoginVC(complete: nil)
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigitionHidden = false
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    ///设置状态栏
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func shopCart(_ sender: UIButton) {
        ///购物车
        tabBarController?.selectedIndex = 2
    }
    @IBAction func myOrder(_ sender: UIButton) {
        ///我的订单
    }
    @IBAction func clickButton(_ sender: UIButton) {
        navigitionHidden = true
        let vcs = ["YYMessageViewController","YYFavoriteViewController","YYTicketViewController","YYExpressViewController","YYAddressViewController","YYSettingViewController"];
        guard let spaceName = Bundle.main.infoDictionary?["CFBundleName"] as? String,
         let classVC = NSClassFromString(spaceName + "." + vcs[sender.tag - 1]) as? WYBaseViewController.Type else {
            return
        }
        let vc = classVC.init()
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension WYMineViewController {
    ///判断是否登录
    func isLogin() -> Bool{
        guard let _ = WYCommomMethod.valueForKey(key: ACCESS_TOKEN) else {
            return false;
        }
        return true;
    }
}

//
//  WYLoginViewController.swift
//  DiYa
//
//  Created by wangyang on 2017/9/28.
//  Copyright © 2017年 wangyang. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import MJExtension
import YYModel

class WYLoginViewController: WYBaseViewController {
    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var registerButton: UIButton!
    
    @IBOutlet weak var phoneTF: UITextField!
    @IBOutlet weak var codeLabel: UILabel!
    
    @IBOutlet weak var passTF: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var forgetButton: UIButton!
    
    fileprivate var isLogin = true
    
    var userInfo = UserInfo()
    
    
    override func awakeFromNib() {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        phoneTF.text = "13516829309"
        passTF.text = "qqqqqqqq"
        changeViewState()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func sendCode(_ sender: UIButton) {
        
    }
    
    @IBAction func forgetPassword(_ sender: UIButton) {
        
    }
    
    @IBAction func goToNext(_ sender: UIButton) {
        
        guard let phone = phoneTF.text,
            let password = passTF.text else {
                return
        }
        
        let dic = ["mobile":phone,"password":password]
        requestLogin(dic: dic) { (isSuccess) in
            if isSuccess {
                //
            }else {
                //
            }
        }
    }
    
    @IBAction func login(_ sender: UIButton) {
        isLogin = true
        changeViewState()
    }
    
    @IBAction func register(_ sender: UIButton) {
        isLogin = false
        changeViewState()
    }
}

extension WYLoginViewController {
    fileprivate func changeViewState() {
        if isLogin == true {
            bgImageView.image = UIImage(named:"ic_login_top")
            loginButton.setTitleColor(UIColor.hexString(colorString: "333333"), for: .normal)
            registerButton.setTitleColor(UIColor.hexString(colorString: "c1c1c1"), for: .normal)
            sendButton.isHidden = true
            codeLabel.text = "密码"
            passTF.placeholder = "请输入密码"
            forgetButton.isHidden = false
        }else {
            bgImageView.image = UIImage(named:"ic_regist_top")
            registerButton.setTitleColor(UIColor.hexString(colorString: "333333"), for: .normal)
            loginButton.setTitleColor(UIColor.hexString(colorString: "c1c1c1"), for: .normal)
            sendButton.isHidden = false
            codeLabel.text = "验证码"
            passTF.placeholder = "请输入验证码"
            forgetButton.isHidden = true
        }
    }
}

extension WYLoginViewController {
    func requestLogin(dic:[String:String], complete:((_ isSuccess:Bool)->())?) {
        //
        WYNetWorkTool.share.request(url: "/user/login.htm", dic: dic) { (isSuccess, result) in
            if isSuccess {
                guard let result = result,
                    let dic = result["data"] else {
                        return
                }
                self.userInfo = UserInfo.yy_model(withJSON: dic)!
                if self.userInfo.accessToken.count > 0 {
                    WYCommomMethod.saveValue(value: self.userInfo.accessToken, key: ACCESS_TOKEN)
                }
                self.dismiss(animated: true, completion: {
                    //
                })
            }
        }
    }
}

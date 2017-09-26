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

        self.navigationItem.title = "首页"
//
//        let button : UIButton = UIButton.wy_imageButton("ic_tabbar_home_dark")
//        button.sizeToFit()
//        button.center = CGPoint(x: self.view.bounds.size.width / 2.0, y: self.view.bounds.size.height / 2.0)
//        self.view.addSubview(button)
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

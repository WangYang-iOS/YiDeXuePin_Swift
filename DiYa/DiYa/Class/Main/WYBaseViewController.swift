//
//  WYBaseViewController.swift
//  DiYa
//
//  Created by wangyang on 2017/9/26.
//  Copyright © 2017年 wangyang. All rights reserved.
//

import UIKit

class WYBaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(endEdit))
        view.addGestureRecognizer(tap)
    }
    
    @objc fileprivate func endEdit() {
        self.view .endEditing(true)
    }
    
    func presentLoginVC(complete : (()->())?) -> () {
        self.present(WYNavigationController(rootViewController: WYLoginViewController()), animated: true) {
            complete?()
        }
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

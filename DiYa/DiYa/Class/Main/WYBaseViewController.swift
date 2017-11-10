//
//  WYBaseViewController.swift
//  DiYa
//
//  Created by wangyang on 2017/9/26.
//  Copyright © 2017年 wangyang. All rights reserved.
//

import UIKit

class WYBaseViewController: UIViewController {

    var pageNumber = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(endEdit))
        tap.delegate = self;
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
    }
}

extension UIViewController:UIGestureRecognizerDelegate {
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        let touchClass = NSStringFromClass((touch.view?.classForCoder)!)
        let supClass = NSStringFromClass((touch.view?.superview!.superview?.classForCoder)!)
        if touchClass == "UITableView" || touchClass == "UICollectionView" ||
            supClass == "UITableView" || supClass == "UICollectionView" {
            return false
        }
        return true
    }
}

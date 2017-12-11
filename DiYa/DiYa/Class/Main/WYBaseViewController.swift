//
//  WYBaseViewController.swift
//  DiYa
//
//  Created by wangyang on 2017/9/26.
//  Copyright © 2017年 wangyang. All rights reserved.
//

import UIKit
import YYWebImage

class WYBaseViewController: UIViewController {

    var pageNumber = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        automaticallyAdjustsScrollViewInsets = false
        
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(endEdit))
        tap.delegate = self;
        view.addGestureRecognizer(tap)
        
        if navigationController?.viewControllers.count ?? 0 > 1 {
            leftBarButton()
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(presentLoginVC), name: NSNotification.Name(rawValue:NSNotificationNameTokenOutTime), object: nil)
    }
    
    @objc fileprivate func endEdit() {
        self.view .endEditing(true)
    }
    
    @objc func presentLoginVC(complete : (()->())?) -> () {
        self.present(WYNavigationController(rootViewController: WYLoginViewController()), animated: true) {
            complete?()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        YYWebImageManager.shared().cache?.memoryCache.removeAllObjects()
        YYWebImageManager.shared().cache?.diskCache.removeAllObjects()
    }
    
    @objc func clickLeftButton() {
        navigationController?.popViewController(animated: true)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue:NSNotificationNameTokenOutTime), object: nil)
    }
}

extension WYBaseViewController:UIGestureRecognizerDelegate {
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

extension WYBaseViewController {
    func leftBarButton() {
        let button = UIButton()
        button.setImage(UIImage(named:"ic_login_back"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsetsMake(0, -30, 0, 0)
        button.sizeToFit()
        button.bounds = CGRect(x: 0, y: 0, width: 40, height: button.bounds.height)
        button.addTarget(self, action: #selector(clickLeftButton), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
    }
}

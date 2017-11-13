//
//  WYTabBarController.swift
//  DiYa
//
//  Created by wangyang on 2017/9/26.
//  Copyright © 2017年 wangyang. All rights reserved.
//

import UIKit

class WYTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tabBar.tintColor = UIColor.hexString(colorString: "da2d27")
        delegate = self
        setUI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension WYTabBarController {
    fileprivate func setUI() {
        let array = [["vcName":"WYHomeViewController","imageName":"_home_"],
                     ["vcName":"WYClassViewController","imageName":"_class_"],
                     ["vcName":"WYShopCartController","imageName":"_cart_"],
                     ["vcName":"WYMineViewController","imageName":"_personal_"]]
        var childs = [UIViewController]()
        
        for dic in array {
            childs.append(addChilds(dictionary: dic))
        }
        viewControllers = childs
    }
    
    fileprivate func addChilds(dictionary:[String:String]) -> UIViewController {
        
        let spaceName = Bundle.main.infoDictionary?["CFBundleName"] as? String ?? ""
        
        guard
        let imgName = dictionary["imageName"],
        let vcName = dictionary["vcName"],
        let vcClass = NSClassFromString(spaceName + "." + vcName) as? UIViewController.Type else {
            return UIViewController()
        }
        let vc = vcClass.init()
        vc.tabBarItem.image = UIImage(named: "ic_tabbar" + imgName + "dark")
        vc.tabBarItem.selectedImage = UIImage(named: "ic_tabbar" + imgName + "light")
        vc.tabBarItem.imageInsets = UIEdgeInsetsMake(5.5, 0, -5.5, 0)
        //设置标题字体
    vc.tabBarItem.setTitleTextAttributes([NSAttributedStringKey.foregroundColor:UIColor.orange], for: .selected)
        //系统默认12号，修改字体大小要设置Normal的字体大小
    vc.tabBarItem.setTitleTextAttributes([NSAttributedStringKey.font:UIFont.systemFont(ofSize: 12)], for: .normal)
        
        let nav = WYNavigationController.init(rootViewController: vc)
        return nav
    }
}

extension WYTabBarController:UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let spaceName = Bundle.main.infoDictionary?["CFBundleName"] as? String ?? ""
        let vc = (viewController as! WYNavigationController).visibleViewController
        if NSStringFromClass(vc!.classForCoder) == (spaceName + ".WYClassViewController") {
            let vc = vc as! WYClassViewController
            vc.requestCategoryList()
        }
        
    }
}

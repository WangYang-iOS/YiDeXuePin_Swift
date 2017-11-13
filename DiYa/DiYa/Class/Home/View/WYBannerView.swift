//
//  WYBannerView.swift
//  DiYa
//
//  Created by wangyang on 2017/11/13.
//  Copyright © 2017年 wangyang. All rights reserved.
//

import UIKit

class WYBannerView: UIView {

    var scrollView:UIScrollView! {
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height))
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self
        return scrollView
    }
    var pageControl:UIPageControl! {
        let pageControl = UIPageControl(frame: CGRect(x: 0, y: 0, width: 50, height: 5))
        pageControl.center.y = bounds.height - 10
        pageControl.center.x = bounds.width / 2.0
        pageControl.tintColor = UIColor.white
        pageControl.currentPageIndicatorTintColor = UIColor.red
        pageControl.currentPage = 0
        return pageControl
    }
    
    var bannerArray : [String]?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(scrollView)
        addSubview(pageControl)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension WYBannerView {
    func loadBanners(bannerList : [String]?) {
        bannerArray = bannerList
        guard let array = bannerList else {
            return
        }
        
        for subView in scrollView.subviews {
            if subView.isMember(of: UIImageView.self) {
                subView.removeFromSuperview()
            }
        }
        
        pageControl.numberOfPages = array.count
        
        let width = frame.size.width
        let height = frame.size.height
        
        if array.count == 1 {
            pageControl.isHidden = true
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: width, height: height))
            scrollView.addSubview(imageView)
            imageView.yy_setImage(with: URL(string: array[0]), placeholder: UIImage(named: "ic_home_logo"))
            return
        }else {
            pageControl.isHidden = false
        }
        
        let firstImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        scrollView.addSubview(firstImageView)
        firstImageView.yy_setImage(with: URL(string: array.last ?? ""), placeholder: UIImage(named: "ic_home_logo"))
        
        let lastImageView = UIImageView(frame: CGRect(x: width * CGFloat(array.count + 1), y: 0, width: width, height: height))
        scrollView.addSubview(lastImageView)
        lastImageView.yy_setImage(with: URL(string: array.first ?? ""), placeholder: UIImage(named: "ic_home_logo"))
        
        for (i,pic) in array.enumerated() {
            let imageView = UIImageView(frame: CGRect(x: CGFloat(i + 1) * width, y: 0, width: width, height: height))
            scrollView.addSubview(imageView)
            imageView.yy_setImage(with: URL(string: pic), placeholder: UIImage(named: "ic_home_logo"))
            imageView.backgroundColor = UIColor.red
            print(imageView)
        }
        scrollView.contentOffset = CGPoint(x: width, y: 0)
        scrollView.contentSize = CGSize(width: CGFloat(array.count + 2) * width, height: height)
    }
}

extension WYBannerView:UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        ///
        var index = Int(scrollView.contentOffset.x / frame.size.width + 0.5)
        
        guard let array = bannerArray else {
            return
        }
        
        if index == 0 {
            index = array.count
        }else {
            if index == array.count + 1 {
                index = 1
            }
        }
        pageControl.currentPage = Int(index) - 1
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        ///
        guard let array = bannerArray else {
            return
        }
        let index = Int(scrollView.contentOffset.x / frame.size.width + 0.5)
        if index == array.count + 1 {
            scrollView.setContentOffset(CGPoint(x:frame.size.width,y:0), animated: false)
        }else {
            if index == 0 {
                scrollView.setContentOffset(CGPoint(x:CGFloat(array.count) * bounds.width,y:0), animated: false)
            }
        }
    }
}


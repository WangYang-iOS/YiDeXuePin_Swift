//
//  TwoClassView.swift
//  DiYa
//
//  Created by wangyang on 2017/11/9.
//  Copyright © 2017年 wangyang. All rights reserved.
//

import UIKit

class TwoClassView: UIView {

    @IBOutlet weak var collectionView: UICollectionView!

    var categoryModel : [CategoryModel]? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUI()
    }
}

extension TwoClassView {
    fileprivate func setUI() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib.init(nibName: "TwoClassCell", bundle: nil), forCellWithReuseIdentifier: "TwoClassCell")
        collectionView.register(UINib.init(nibName: "ClassReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "ClassReusableView")
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "footer")
    }
}

extension TwoClassView:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TwoClassCell", for: indexPath) as? TwoClassCell
        let model = categoryModel?[indexPath.section]
        cell?.goodsModel = model?.goodsCategoryList[indexPath.row]
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == "UICollectionElementKindSectionHeader" {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "ClassReusableView", for: indexPath) as! ClassReusableView
            let model = categoryModel?[indexPath.section]
            headerView.classLabel.text = model?.name
            return headerView
        }else {
            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "footer", for: indexPath)
            return footerView
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (SCREEN_WIDTH - 90 - 20 - 22) / 3.0;
        return CGSize(width: width, height: width + CGFloat(20))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 44)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 0.01)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let list = categoryModel?[section] else {
            return 0
        }
        return list.goodsCategoryList.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return categoryModel?.count ?? 0
    }
}

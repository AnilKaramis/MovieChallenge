//
//  UICollectionViewLayout+Extensions.swift
//  Teknasyon MVVM Template
//
//  Created by YusufDemirkoparan on 11.07.2024.
//

import UIKit

public extension UICollectionViewLayout {
    static func createFlowLayout(itemSize: CGSize = .zero,
                                 minimumLineSpacing: CGFloat = 10.0,
                                 minimumInteritemSpacing: CGFloat = 10.0,
                                 sectionInset: UIEdgeInsets = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)) -> UICollectionViewFlowLayout {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = itemSize
        flowLayout.minimumLineSpacing = minimumLineSpacing
        flowLayout.minimumInteritemSpacing = minimumInteritemSpacing
        flowLayout.sectionInset = sectionInset
        flowLayout.scrollDirection = .vertical

        return flowLayout
    }
}

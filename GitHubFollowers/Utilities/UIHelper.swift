//
//  UIHelper.swift
//  GitHubFollowers
//
//  Created by Māris Lakšs on 25/11/2023.
//

import UIKit

struct UIHelper {

    static func createThreeColumnFlowLayout(in view: UIView) -> UICollectionViewFlowLayout {
        // Initialize the flow layout
        let width                       = view.bounds.width
        let padding: CGFloat            = 12
        let minimumItemSpacing: CGFloat = 10
        let availableWidth              = width - (padding * 2) - (minimumItemSpacing * 2)
        let itemWidth                   = availableWidth / 3

        let flowLayout                  = UICollectionViewFlowLayout()
        // Set the item size
        flowLayout.itemSize             = CGSize(width: itemWidth, height: itemWidth + 40)
        // Set the section inset
        flowLayout.sectionInset         = UIEdgeInsets(
            top: padding,
            left: padding,
            bottom: padding,
            right: padding
        )
        // Set the minimum line spacing
        flowLayout.minimumLineSpacing   = minimumItemSpacing

        return flowLayout
    }
}

//
//  UIHelper.swift
//  GitHubFollowers
//
//  Created by Māris Lakšs on 25/11/2023.
//

import UIKit

// MARK: - UIHelper

// `UIHelper` serves as a namespace for utility functions related to UI configurations,
// preventing instantiation and providing static methods.
enum UIHelper {

    /// Creates a three-column flow layout for UICollectionViews.
        /// - Parameter view: The UIView within which the UICollectionView is placed.
        /// - Returns: A configured UICollectionViewFlowLayout with three columns.
        ///
        /// This method calculates the dimensions and spacing for items based on the provided view's width,
        /// allowing for dynamic layout adjustments based on the device's screen size or the view's current size.
    static func createThreeColumnFlowLayout(in view: UIView) -> UICollectionViewFlowLayout {
        let width                       = view.bounds.width
        let padding: CGFloat            = 12
        let minimumItemSpacing: CGFloat = 10
        let availableWidth              = width - (padding * 2) - (minimumItemSpacing * 2)
        let itemWidth                   = availableWidth / 3

        let flowLayout                  = UICollectionViewFlowLayout()

        flowLayout.itemSize             = CGSize(width: itemWidth, height: itemWidth + 40)
        flowLayout.sectionInset         = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.minimumLineSpacing   = minimumItemSpacing

        return flowLayout
    }
}

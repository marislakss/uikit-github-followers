//
//  UIView+Ext.swift
//  GitHubFollowers
//
//  Created by Māris Lakšs on 09/04/2024.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
}


//
//  UIView+Ext.swift
//  GitHubFollowers
//
//  Created by Māris Lakšs on 09/04/2024.
//

import UIKit

// MARK: - UIView Extension

// This extension adds utility methods to UIView to simplify common layout tasks.
extension UIView {
    
    // Pins the current view's edges to the specified superview's edges.
    func pinToEdges(of superview: UIView) {
        // Disable autoresizing mask constraints
        translatesAutoresizingMaskIntoConstraints = false
        // Activate constraints to pin each edge
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superview.topAnchor),
            leadingAnchor.constraint(equalTo: superview.leadingAnchor),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor)
        ])
    }

    // Adds an array of UIViews as subviews to the current view.
    func addSubviews(_ views: UIView...) {
        for view in views { addSubview(view) }
    }
}


//
//  UITableView+Ext.swift
//  GitHubFollowers
//
//  Created by Māris Lakšs on 10/04/2024.
//

import UIKit

// MARK: - UITableView Extension

extension UITableView {
    
    // Function to remove excess empty cells by setting tableFooterView to an empty UIView
    func removeExcessCells() {
        tableFooterView = UIView(frame: .zero)
    }
}

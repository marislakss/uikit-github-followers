//
//  FollowerCell.swift
//  GitHubFollowers
//
//  Created by Māris Lakšs on 24/11/2023.
//

import UIKit
import SwiftUI

// MARK: - FollowerCell Class

// FollowerCell is a subclass of UICollectionViewCell, it's a custom cell used for displaying follower data.
class FollowerCell: UICollectionViewCell {

    // MARK: - Properties
    
    static let reuseID  = "FollowerCell"

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Set Methods

    func set(follower: Follower) {
        contentConfiguration = UIHostingConfiguration { FollowerView(follower: follower) }
    }
}

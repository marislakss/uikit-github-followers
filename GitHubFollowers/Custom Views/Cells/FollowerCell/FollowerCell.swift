//
//  FollowerCell.swift
//  GitHubFollowers
//
//  Created by Māris Lakšs on 24/11/2023.
//

import UIKit
import SwiftUI

class FollowerCell: UICollectionViewCell {
    static let reuseID  = "FollowerCell"

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    func set(follower: Follower) {
            contentConfiguration = UIHostingConfiguration { FollowerView(follower: follower) }
    }
}

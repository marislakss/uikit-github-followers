//
//  GFFollowerItemVC.swift
//  GitHubFollowers
//
//  Created by Māris Lakšs on 04/12/2023.
//

import UIKit

// MARK: - Protocol Definition

// GFFollowerItemVCDelegate is a protocol that defines a method for handling the tap action
// on the 'Get Followers' button in the GFFollowerItemVC view controller.
protocol GFFollowerItemVCDelegate: AnyObject {
    func didTapGetFollowers(for user: User)
}

// MARK: - GFFollowerItemVC Class

// GFFollowerItemVC is a subclass of GFItemInfoVC, it presents follower count and
// 'Get Followers' button to the user.
class GFFollowerItemVC: GFItemInfoVC {

    // MARK: - Properties
    
    weak var delegate: GFFollowerItemVCDelegate!

    // MARK: - Initialization

    init(user: User, delegate: GFFollowerItemVCDelegate) {
        super.init(user: user)
        self.delegate = delegate
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureItems()
    }

    // MARK: - Configuration

    private func configureItems() {
        itemInfoViewOne.set(itemInfoType: .followers, withCount: user.followers)
        itemInfoViewTwo.set(itemInfoType: .following, withCount: user.following)

        actionButton.set(color: .systemGreen, title: "Get Followers", systemImageName: "person.fill.badge.plus")
    }

    // MARK: - Actions

    override func actionButtonTapped() {
        delegate.didTapGetFollowers(for: user)
    }
}

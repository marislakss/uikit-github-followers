//
//  GFFollowerItemVC.swift
//  GitHubFollowers
//
//  Created by Māris Lakšs on 04/12/2023.
//

import UIKit

protocol GFFollowerItemVCDelegate: AnyObject {
    func didTapGetFollowers(for user: User)
}

class GFFollowerItemVC: GFItemInfoVC {
    weak var delegate: GFFollowerItemVCDelegate!

    init(user: User, delegate: GFFollowerItemVCDelegate) {
        super.init(user: user)
        self.delegate = delegate
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureItems()
    }

    private func configureItems() {
        itemInfoViewOne.set(itemInfoType: .followers, withCount: user.followers)
        itemInfoViewTwo.set(itemInfoType: .following, withCount: user.following)

        actionButton.set(color: .systemGreen, title: "Get Followers", systemImageName: "person.3.fill")
    }

    override func actionButtonTapped() {
        delegate.didTapGetFollowers(for: user)
    }
}

//
//  GFRepoItemVC.swift
//  GitHubFollowers
//
//  Created by Māris Lakšs on 04/12/2023.
//

import UIKit

protocol GFRepoItemVCDelegate: AnyObject {
    func didTapGitHubProfile(for user: User)
}

class GFRepoItemVC: GFItemInfoVC {
    // Use weak on delegate to avoid retain cycles
    // A retain cycle, also known as a circular reference, occurs when two or more objects
    // reference each other strongly, preventing them from being deallocated.
    weak var delegate: GFRepoItemVCDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }

    private func configureItems() {
        itemInfoViewOne.set(itemInfoType: .repos, withCount: user.publicRepos)
        itemInfoViewTwo.set(itemInfoType: .gists, withCount: user.publicGists)

        actionButton.set(backgroundColor: .systemPurple, title: "GitHub Profile")
    }

    override func actionButtonTapped() {
        delegate.didTapGitHubProfile(for: user)
    }
}

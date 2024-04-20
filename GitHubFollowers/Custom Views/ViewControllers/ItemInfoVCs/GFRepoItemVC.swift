//
//  GFRepoItemVC.swift
//  GitHubFollowers
//
//  Created by Māris Lakšs on 04/12/2023.
//

import UIKit

// MARK: - Protocol Definition

protocol GFRepoItemVCDelegate: AnyObject {
    func didTapGitHubProfile(for user: User)
}

// MARK: - GFRepoItemVC Class

class GFRepoItemVC: GFItemInfoVC {
    // Use weak on delegate to avoid retain cycles
    // A retain cycle, also known as a circular reference, occurs when two or more objects
    // reference each other strongly, preventing them from being deallocated.
    weak var delegate: GFRepoItemVCDelegate!
    
    // MARK: - Initialization

    init(user: User, delegate: GFRepoItemVCDelegate) {
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
        itemInfoViewOne.set(itemInfoType: .repos, withCount: user.publicRepos)
        itemInfoViewTwo.set(itemInfoType: .gists, withCount: user.publicGists)

        actionButton.set(color: .systemPurple, title: "GitHub Profile", systemImageName: "person.fill")
    }

    // MARK: - Actions

    override func actionButtonTapped() {
        delegate.didTapGitHubProfile(for: user)
    }
}

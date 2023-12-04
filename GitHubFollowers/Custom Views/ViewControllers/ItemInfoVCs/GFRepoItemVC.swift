//
//  GFRepoItemVC.swift
//  GitHubFollowers
//
//  Created by Māris Lakšs on 04/12/2023.
//

import UIKit

class GFRepoItemVC: GFItemInfoVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    private func configureItems() {
        itemInfoViewOne.set(itemInfoType: .repos, withCount: user.publicRepos)
        itemInfoViewTwo.set(itemInfoType: .gists, withCount: user.publicGists)
    
        actionButton.set(backgroundColor: .systemPurple, title: "GitHub Profile")
    }
}

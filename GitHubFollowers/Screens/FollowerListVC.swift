//
//  FollowerListVC.swift
//  GitHubFollowers
//
//  Created by Māris Lakšs on 06/11/2023.
//

import UIKit

class FollowerListVC: UIViewController {
    var username: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true

        // This is called 'call site' in Swift
        NetworkManager.shared.getFollowers(for: username, page: 1) { result in
            switch result {
                // In case success, we get an array of followers
            case let .success(followers):
                print(followers)
            // In case failure, present the alert
            case let .failure(error):
                self.presentGFAlertOnMainThread(
                    title: "Bad Stuff Happened",
                    message: error.rawValue,
                    buttonTitle: "OK"
                )
            }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}

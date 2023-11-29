//
//  UserInfoVC.swift
//  GitHubFollowers
//
//  Created by Māris Lakšs on 29/11/2023.
//

import UIKit

class UserInfoVC: UIViewController {
    var username: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        // Create a done button
        let doneButton = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(dismissVC)
        )
        // Add the done button to the navigation bar
        navigationItem.rightBarButtonItem = doneButton
        configureNavigationBar()

        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let user):
                print(user)
//                DispatchQueue.main.async {
//                    self.add(childVC: GFUserInfoHeaderVC(user: user), to: self.view)
//                }
            case .failure(let error):
                self.presentGFAlertOnMainThread(
                    title: "Something went wrong",
                    message: error.rawValue,
                    buttonTitle: "OK"
                )
            }
        }
    }

    @objc func dismissVC() {
        dismiss(animated: true)
    }

    func configureNavigationBar() {
        if #available(iOS 15, *) {
            navigationController?.navigationBar.scrollEdgeAppearance = UINavigationBarAppearance()
        }
    }
}

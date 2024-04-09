//
//  UserInfoVC.swift
//  GitHubFollowers
//
//  Created by Māris Lakšs on 29/11/2023.
//

import UIKit

protocol UserInfoVCDelegate: AnyObject {
    func didTapGitHubProfile(for user: User)
    func didTapGetFollowers(for user: User)
}

// UserInfoVC is a subclass of GFDataLoadingVC superclass
class UserInfoVC: GFDataLoadingVC {
    let headerView = UIView()
    let itemViewOne = UIView()
    let itemViewTwo = UIView()
    let dateLabel = GFBodyLabel(textAlignment: .center)
    var itemViews: [UIView] = []

    var username: String!
    weak var delegate: FollowerListVCDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureNavigationBar()
        layoutUI()
        getUserInfo()
    }

    func configureViewController() {
        view.backgroundColor = .systemBackground
        // Create a done button
        let doneButton = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(dismissVC)
        )
        // Add the done button to the navigation bar
        navigationItem.rightBarButtonItem = doneButton
    }

    func getUserInfo() {
        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
            guard let self else { return }

            switch result {
            case let .success(user):
                DispatchQueue.main.async { self.configureUIElements(with: user) }

            case let .failure(error):
                self.presentGFAlertOnMainThread(
                    title: "Something went wrong",
                    message: error.rawValue,
                    buttonTitle: "OK"
                )
            }
        }
    }

    func configureUIElements(with user: User) {
        let repoItemVC = GFRepoItemVC(user: user)
        repoItemVC.delegate = self

        let followerItemVC = GFFollowerItemVC(user: user)
        followerItemVC.delegate = self

        add(childVC: repoItemVC, to: itemViewOne)
        add(childVC: followerItemVC, to: itemViewTwo)
        add(childVC: GFUserInfoHeaderVC(user: user), to: headerView)
        dateLabel.text = "On GitHub since \(user.createdAt.convertToMonthYearFormat())"
    }

    func layoutUI() {
        let padding: CGFloat = 20
        let itemHeight: CGFloat = 140

        itemViews = [headerView, itemViewOne, itemViewTwo, dateLabel]

        for itemView in itemViews {
            view.addSubview(itemView)
            itemView.translatesAutoresizingMaskIntoConstraints = false

            NSLayoutConstraint.activate([
                itemView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
                itemView.trailingAnchor.constraint(
                    equalTo: view.trailingAnchor,
                    constant: -padding
                ),
            ])
        }

//        // Set the background colors for debugging
//        itemViewOne.backgroundColor = .systemPink
//        itemViewTwo.backgroundColor = .systemBlue

        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 210),

            itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            itemViewOne.heightAnchor.constraint(equalToConstant: itemHeight),

            itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: padding),
            itemViewTwo.heightAnchor.constraint(equalToConstant: itemHeight),

            dateLabel.topAnchor.constraint(equalTo: itemViewTwo.bottomAnchor, constant: padding),
            dateLabel.heightAnchor.constraint(equalToConstant: 50),
        ])
    }

    func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
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

extension UserInfoVC: UserInfoVCDelegate {
    func didTapGitHubProfile(for user: User) {
        // Show Safari View Controller
        guard let url = URL(string: user.htmlUrl) else {
            presentGFAlertOnMainThread(
                title: "Invalid URL",
                message: "The url attached to this user is invalid.",
                buttonTitle: "OK"
            )
            return
        }
        presentSafariVC(with: url)
    }

    func didTapGetFollowers(for user: User) {
        // Tell FollowersListVC the new user
        guard user.followers != 0 else {
            presentGFAlertOnMainThread(
                title: "No Followers!",
                message: "This user has no followers. 😞",
                buttonTitle: "OK"
            )
            return
        }
        delegate.didRequestFollowers(for: user.login)
        dismissVC()
    }
}

//
//  UserInfoVC.swift
//  GitHubFollowers
//
//  Created by Māris Lakšs on 29/11/2023.
//

import UIKit

protocol UserInfoVCDelegate: AnyObject {
    func didRequestFollowers(for username: String)
}

// UserInfoVC is a subclass of GFDataLoadingVC superclass
class UserInfoVC: GFDataLoadingVC {
    // Create the scrollView and contentView programatically
    let scrollView          = UIScrollView()
    let contentView         = UIView()

    let headerView          = UIView()
    let itemViewOne         = UIView()
    let itemViewTwo         = UIView()
    let dateLabel           = GFBodyLabel(textAlignment: .center)
    var itemViews: [UIView] = []

    var username: String!
    weak var delegate: UserInfoVCDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()

        configureViewController()
        configureScrollView()
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

    func configureScrollView() {
        // Add scrollView to the view
        view.addSubview(scrollView)
        // Add contentView to the scrollView
        scrollView.addSubview(contentView)
        // Use the pinToEdges method from the UIView extension
        scrollView.pinToEdges(of: view)
        // Use the pinToEdges method from the UIView extension to pin the contentView to the scrollView
        contentView.pinToEdges(of: scrollView)
        
        // Set the explicit width and height constraints of the contentView
        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 600)
        ])
    }

    func getUserInfo() {

        Task {
            do {
                let user = try await NetworkManager.shared.getUserInfo(for: username)
                configureUIElements(with: user)
            } catch {
                if let gfError = error as? GFError {
                    presentGFAlert(
                        title: "Something went wrong",
                        message: gfError.rawValue,
                        buttonTitle: "OK"
                    )
                } else {
                    presentDefaultError()
                }
            }
        }
    }

    func configureUIElements(with user: User) {
        add(childVC: GFRepoItemVC(user: user, delegate: self), to: itemViewOne)
        add(childVC: GFFollowerItemVC(user: user, delegate: self), to: itemViewTwo)
        add(childVC: GFUserInfoHeaderVC(user: user), to: headerView)
        dateLabel.text = "On GitHub since \(user.createdAt.convertToMonthYearFormat())"
    }

    func layoutUI() {
        let padding: CGFloat    = 20
        let itemHeight: CGFloat = 140

        itemViews = [headerView, itemViewOne, itemViewTwo, dateLabel]

        for itemView in itemViews {
            contentView.addSubview(itemView)
            itemView.translatesAutoresizingMaskIntoConstraints = false

            NSLayoutConstraint.activate([
                itemView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
                itemView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding)
            ])
        }

//        // Set the background colors for debugging
//        itemViewOne.backgroundColor = .systemPink
//        itemViewTwo.backgroundColor = .systemBlue

        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 210),

            itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            itemViewOne.heightAnchor.constraint(equalToConstant: itemHeight),

            itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: padding),
            itemViewTwo.heightAnchor.constraint(equalToConstant: itemHeight),

            dateLabel.topAnchor.constraint(equalTo: itemViewTwo.bottomAnchor, constant: padding),
            dateLabel.heightAnchor.constraint(equalToConstant: 50)
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

extension UserInfoVC: GFRepoItemVCDelegate {
    func didTapGitHubProfile(for user: User) {
        // Show Safari View Controller
        guard let url = URL(string: user.htmlUrl) else {
            presentGFAlert(
                title: "Invalid URL",
                message: "The url attached to this user is invalid.",
                buttonTitle: "OK"
            )
            return
        }

        presentSafariVC(with: url)
    }
}

extension UserInfoVC: GFFollowerItemVCDelegate {
    func didTapGetFollowers(for user: User) {
        // Tell FollowersListVC the new user
        guard user.followers != 0 else {
            presentGFAlert(
                title: "No Followers!",
                message: "This user has no followers.",
                buttonTitle: "OK"
            )
            return
        }

        delegate.didRequestFollowers(for: user.login)
        dismissVC()
    }
}

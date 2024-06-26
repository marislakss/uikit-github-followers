//
//  GFUserInfoHeaderVC.swift
//  GitHubFollowers
//
//  Created by Māris Lakšs on 30/11/2023.
//

import UIKit

// MARK: - GFUserInfoHeaderVC Class

// GFUserInfoHeaderVC is a subclass of UIViewController.
// It presents user information at the top of the user profile screen.
class GFUserInfoHeaderVC: UIViewController {

    // MARK: - Properties
    
    let avatarImageView   = GFAvatarImageView(frame: .zero)
    let usernameLabel     = GFTitleLabel(textAlignment: .left, fontSize: 34)
    let nameLabel         = GFSecondaryTitleLabel(fontSize: 18)
    let locationImageView = UIImageView()
    let locationLabel     = GFSecondaryTitleLabel(fontSize: 18)
    let bioLabel          = GFBodyLabel(textAlignment: .left)

    var user: User!
    
    // MARK: - Initialization

    // Custom initializer
    init(user: User) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }

    // This initializer is called when we create a VC from storyboard
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubviews(avatarImageView, usernameLabel, nameLabel, locationImageView, locationLabel, bioLabel)
        
        layoutUI()
        configureUIElements()
    }

    // MARK: - Configuration

    func configureUIElements() {
        avatarImageView.downloadImage(fromURL: user.avatarUrl)
        usernameLabel.text     = user.login
        nameLabel.text         = user.name ?? ""
        locationLabel.text     = user.location ?? "No location"
        bioLabel.text          = user.bio ?? "No bio available"
        bioLabel.numberOfLines = 3
        bioLabel.lineBreakMode = .byTruncatingTail

        locationImageView.image     = SFSymbols.location
        locationImageView.tintColor = .secondaryLabel
    }

    // MARK: - Layout
    
    func layoutUI() {
        let padding: CGFloat          = 20
        let textImagePadding: CGFloat = 12
        locationImageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            // Add constraints to the avatar image view
            avatarImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            avatarImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            avatarImageView.heightAnchor.constraint(equalToConstant: 90),
            avatarImageView.widthAnchor.constraint(equalToConstant: 90),

            // Add constraints to the username label
            usernameLabel.topAnchor.constraint(equalTo: avatarImageView.topAnchor),
            usernameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
            usernameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            usernameLabel.heightAnchor.constraint(equalToConstant: 38),

            // Add constraints to the name label
            nameLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 20),

            // Add constraints to the location image view
            locationImageView.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor),
            locationImageView.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
            locationImageView.heightAnchor.constraint(equalToConstant: 20),
            locationImageView.widthAnchor.constraint(equalToConstant: 20),

            // Add constraints to the location label
            locationLabel.centerYAnchor.constraint(equalTo: locationImageView.centerYAnchor),
            locationLabel.leadingAnchor.constraint(equalTo: locationImageView.trailingAnchor, constant: 5),
            locationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            locationLabel.heightAnchor.constraint(equalToConstant: 20),

            // Add constraints to the bio label
            bioLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: textImagePadding),
            bioLabel.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor),
            bioLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bioLabel.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
}

//
//  GFItemInfoView.swift
//  GitHubFollowers
//
//  Created by Māris Lakšs on 04/12/2023.
//

import UIKit

// MARK: - ItemInfoType Enumeration

enum ItemInfoType {
    case repos, gists, followers, following
}

// MARK: - GFItemInfoView Class

class GFItemInfoView: UIView {

    // MARK: - Properties

    let symbolImageView = UIImageView()
    let titleLabel      = GFTitleLabel(textAlignment: .left, fontSize: 14)
    let countLabel      = GFTitleLabel(textAlignment: .center, fontSize: 14)

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        // Configure the view and its subviews
        configure()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Configuration

    private func configure() {
        // Add subviews to the view
        addSubviews(symbolImageView, titleLabel, countLabel)

        symbolImageView.translatesAutoresizingMaskIntoConstraints = false
        symbolImageView.contentMode = .scaleAspectFill
        symbolImageView.tintColor   = .label

        // Layout constraints for subviews
        NSLayoutConstraint.activate([
            symbolImageView.topAnchor.constraint(equalTo: self.topAnchor),
            symbolImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            symbolImageView.widthAnchor.constraint(equalToConstant: 20),
            symbolImageView.heightAnchor.constraint(equalToConstant: 20),

            titleLabel.centerYAnchor.constraint(equalTo: symbolImageView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: symbolImageView.trailingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 18),

            countLabel.topAnchor.constraint(equalTo: symbolImageView.bottomAnchor, constant: 4),
            countLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            countLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            countLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
    }

    // MARK: - Set Item Information

    func set(itemInfoType: ItemInfoType, withCount count: Int) {
        // Configure the view based on the type and count of items
        switch itemInfoType {
        case .repos:
            symbolImageView.image = SFSymbols.repos
            titleLabel.text       = "Public Repos"
        case .gists:
            symbolImageView.image = SFSymbols.gists
            titleLabel.text       = "Public Gists"
        case .followers:
            symbolImageView.image = SFSymbols.followers
            titleLabel.text       = "Followers"
        case .following:
            symbolImageView.image = SFSymbols.following
            titleLabel.text       = "Following"
        }
        
        // Set the count label
        countLabel.text           = String(count)
    }
}

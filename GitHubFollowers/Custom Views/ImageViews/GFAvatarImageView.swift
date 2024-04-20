//
//  GFAvatarImageView.swift
//  GitHubFollowers
//
//  Created by Māris Lakšs on 24/11/2023.
//

import UIKit

// MARK: - GFAvatarImageView Class

// GFAvatarImageView is a subclass of UIImageView, it's a custom ImageView used for
// displaying avatar images throughout the app.
class GFAvatarImageView: UIImageView {

    // MARK: - Properties

    let cache            = NetworkManager.shared.cache
    let placeholderImage = Images.placeholder

    // MARK: - Initialization

    // Override the designated init to call the configure method
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Configuration

    private func configure() {
        layer.cornerRadius = 10
        clipsToBounds      = true
        image              = placeholderImage
        translatesAutoresizingMaskIntoConstraints = false
    }

    // MARK: - Network Calls

    func downloadImage(fromURL url: String) {
        Task { image = await NetworkManager.shared.downloadImage(from: url) ?? placeholderImage }
    }
}

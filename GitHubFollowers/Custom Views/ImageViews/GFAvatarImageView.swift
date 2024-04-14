//
//  GFAvatarImageView.swift
//  GitHubFollowers
//
//  Created by Māris Lakšs on 24/11/2023.
//

import UIKit

class GFAvatarImageView: UIImageView {
    let cache            = NetworkManager.shared.cache
    let placeholderImage = Images.placeholder

    // Override the designated init to call the configure method
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    private func configure() {
        layer.cornerRadius = 10
        clipsToBounds      = true
        image              = placeholderImage
        translatesAutoresizingMaskIntoConstraints = false
    }

    
    func downloadImage(fromURL url: String) {
        NetworkManager.shared.downloadImage(from: url) { [weak self] image in
            guard let self else { return }
            DispatchQueue.main.async { self.image = image }
        }
    }
}

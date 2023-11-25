//
//  GFAvatarImageView.swift
//  GitHubFollowers
//
//  Created by Māris Lakšs on 24/11/2023.
//

import UIKit

class GFAvatarImageView: UIImageView {
    let cache            = NetworkManager.shared.cache
    let placeholderImage = UIImage(named: "avatar-placeholder")!

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) { fatalError("init(coder:) has not been implemented") }

    private func configure() {
        layer.cornerRadius = 10
        clipsToBounds      = true
        image              = placeholderImage
        translatesAutoresizingMaskIntoConstraints = false
    }

    func downloadImage(from urlString: String) {
        // If cached image is available, return
        let cacheKey = NSString(string: urlString)

        if let image = cache.object(forKey: cacheKey) {
            self.image = image
            return
        }

        // If cached image is not available, do the network call to download it
        // Create the URL
        guard let url = URL(string: urlString) else { return }

        // Create the URL session
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in

            // Unwrap self
            guard let self else { return }

            // Check for errors
            if error != nil { return }

            // Check for response
            guard let response = response as? HTTPURLResponse,
                  response.statusCode == 200 else { return }

            // Check for data
            guard let data else { return }

            // Create the image
            guard let image = UIImage(data: data) else { return }

            // Set the image to the cache
            self.cache.setObject(image, forKey: cacheKey)

            // In case successful, switch to the main thread and update the UI to show image to the
            // user
            DispatchQueue.main.async { self.image = image }
        }

        // Start the task
        task.resume()
    }
}

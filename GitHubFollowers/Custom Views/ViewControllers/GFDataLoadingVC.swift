//
//  GFDataLoadingVC.swift
//  GitHubFollowers
//
//  Created by Māris Lakšs on 01/04/2024.
//

import UIKit

class GFDataLoadingVC: UIViewController {
    var containerView: UIView!

    func showLoadingView() {
        // Initialize the containerView
        containerView = UIView(frame: view.bounds)
        // Add the containerView to the view
        view.addSubview(containerView)
        // Set the background color
        containerView.backgroundColor = .systemBackground
        // Set the alpha
        containerView.alpha = 0
        // Animate the alpha
        UIView.animate(withDuration: 0.25) {
            self.containerView.alpha = 0.8
        }
        // Add the activity indicator
        let activityIndicator = UIActivityIndicatorView(style: .large)
        containerView.addSubview(activityIndicator)
        // Center the activity indicator
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
        ])
        // Start animating
        activityIndicator.startAnimating()
    }

    func dismissLoadingView() {
        // Go back to the main thread
        DispatchQueue.main.async {
            // Remove the containerView
            self.containerView.removeFromSuperview()
            // Set the containerView to nil
            self.containerView = nil
        }
    }

    func showEmptyStateView(with message: String, in view: UIView) {
        let emptyStateView = GFEmptyStateView(message: message)
        emptyStateView.frame = view.bounds
        // Hide the search bar when transitioning to the empty state view to
        // provide a cleaner user interface when no followers are found.
        navigationItem.searchController?.searchBar.isHidden = true
        view.addSubview(emptyStateView)
    }
}

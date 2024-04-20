//
//  GFDataLoadingVC.swift
//  GitHubFollowers
//
//  Created by Māris Lakšs on 01/04/2024.
//

import UIKit

// MARK: - GFDataLoadingVC Class

// GFDataLoadingVC is a subclass of UIViewController. It's responsible for presenting and
// dismissing loading and empty state views.
class GFDataLoadingVC: UIViewController {

    // MARK: - Properties

    var containerView: UIView!

    // MARK: - Show Loading

    func showLoadingView() {
        // Initialize the containerView
        containerView                 = UIView(frame: view.bounds)
        // Add the containerView to the view
        view.addSubview(containerView)

        // Set the background color
        containerView.backgroundColor = .systemBackground
        // Set the alpha
        containerView.alpha           = 0

        // Animate the alpha
        UIView.animate(withDuration: 0.25) { self.containerView.alpha = 0.8 }
        // Add the activity indicator

        let activityIndicator = UIActivityIndicatorView(style: .large)
        containerView.addSubview(activityIndicator) // Add the activity indicator

        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        // Center the activity indicator
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
        ])

        // Start animating
        activityIndicator.startAnimating()
    }

    // MARK: - Dismiss Loading

    func dismissLoadingView() {
        // Go back to the main thread
        DispatchQueue.main.async {
            // Remove the containerView
            self.containerView.removeFromSuperview()
            // Set the containerView to nil
            self.containerView = nil
        }
    }

    // MARK: - Show Empty State

    func showEmptyStateView(with message: String, in view: UIView) {
          view.subviews.forEach { subview in
            if subview is GFEmptyStateView {
              subview.removeFromSuperview()
            }
          }
            let emptyStateView = GFEmptyStateView(message: message)
            emptyStateView.frame = view.bounds
            // Hide the search bar when transitioning to the empty state view to
            // provide a cleaner user interface when no followers are found.
            navigationItem.searchController?.searchBar.isHidden = true
            view.addSubview(emptyStateView)
        }
}

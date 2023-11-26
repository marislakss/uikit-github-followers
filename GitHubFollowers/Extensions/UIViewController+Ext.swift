//
//  UIViewController+Ext.swift
//  GitHubFollowers
//
//  Created by Māris Lakšs on 17/11/2023.
//

import UIKit

private var containerView: UIView!

extension UIViewController {
    // Present an alert on the main thread
    func presentGFAlertOnMainThread(title: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let alertVC = GFAlertVC(title: title, message: message, buttonTitle: buttonTitle)
            // Set the presentation style
            alertVC.modalPresentationStyle = .overFullScreen
            // Set the transition style
            alertVC.modalTransitionStyle = .crossDissolve
            // Present the alert
            self.present(alertVC, animated: true)
        }
    }

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
            containerView.alpha = 0.8
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
            containerView.removeFromSuperview()
            // Set the containerView to nil
            containerView = nil
        }
    }

    func showEmptyStateView(with message: String, in view: UIView) {
        let emptyStateView = GFEmptyStateView(message: message)
        emptyStateView.frame = view.bounds
        view.addSubview(emptyStateView)
    }
}

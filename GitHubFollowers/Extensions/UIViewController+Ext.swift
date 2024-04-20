//
//  UIViewController+Ext.swift
//  GitHubFollowers
//
//  Created by Māris Lakšs on 17/11/2023.
//

import UIKit
import SafariServices

// MARK: - UIViewController Extension

// This extension adds additional functionality to UIViewController for 
// presenting customized alerts and Safari web views.
extension UIViewController {

    // MARK: - Alert Presentation

    func presentGFAlert(title: String, message: String, buttonTitle: String) {
        let alertVC = GFAlertVC(title: title, message: message, buttonTitle: buttonTitle)
        // Set the presentation style
        alertVC.modalPresentationStyle = .overFullScreen
        // Set the transition style
        alertVC.modalTransitionStyle   = .crossDissolve
        // Present the alert
        present(alertVC, animated: true)
    }

    // Presents a default error alert with a standard message.
    func presentDefaultError() {
        let alertVC = GFAlertVC(title: "Something went wrong",
                                message: "Please try again",
                                buttonTitle: "OK")
        alertVC.modalPresentationStyle = .overFullScreen
        alertVC.modalTransitionStyle   = .crossDissolve
        present(alertVC, animated: true)
    }

    // MARK: - Safari Web View Presentation

    // Presents a SafariViewController with the specified URL.
    func presentSafariVC(with url: URL) {
        let safariVC = SFSafariViewController(url: url)
        safariVC.preferredControlTintColor = .systemGreen
        present(safariVC, animated: true)
    }
}

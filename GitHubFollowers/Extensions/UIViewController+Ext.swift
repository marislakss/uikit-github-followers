//
//  UIViewController+Ext.swift
//  GitHubFollowers
//
//  Created by Māris Lakšs on 17/11/2023.
//

import UIKit
import SafariServices

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

    func presentSafariVC(with url: URL) {
        let safariVC = SFSafariViewController(url: url)
        safariVC.preferredControlTintColor = .systemGreen
        present(safariVC, animated: true)
    }
}

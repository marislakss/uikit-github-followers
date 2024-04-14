//
//  UIViewController+Ext.swift
//  GitHubFollowers
//
//  Created by Māris Lakšs on 17/11/2023.
//

import UIKit
import SafariServices

extension UIViewController {

    // Present an alert
    func presentGFAlert(title: String, message: String, buttonTitle: String) {
        let alertVC = GFAlertVC(title: title, message: message, buttonTitle: buttonTitle)
        // Set the presentation style
        alertVC.modalPresentationStyle = .overFullScreen
        // Set the transition style
        alertVC.modalTransitionStyle   = .crossDissolve
        // Present the alert
        present(alertVC, animated: true)
    }


    func presentDefaultError() {
        let alertVC = GFAlertVC(title: "Something went wrong",
                                message: "Please try again",
                                buttonTitle: "OK")
        alertVC.modalPresentationStyle = .overFullScreen
        alertVC.modalTransitionStyle   = .crossDissolve
        present(alertVC, animated: true)
    }

    
    func presentSafariVC(with url: URL) {
        let safariVC = SFSafariViewController(url: url)
        safariVC.preferredControlTintColor = .systemGreen
        present(safariVC, animated: true)
    }
}

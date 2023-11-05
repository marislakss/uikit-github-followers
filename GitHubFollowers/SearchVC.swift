//
//  SearchVC.swift
//  GitHubFollowers
//
//  Created by Māris Lakšs on 01/11/2023.
//

import UIKit

class SearchVC: UIViewController {
    let logoImageView = UIImageView()
    let usernameTextField = GFTextField()
    let callToActionButton = GFButton(backgroundColor: .systemGreen, title: "Get Followers")

    override func viewDidLoad() {
        super.viewDidLoad()
        // Adapt the view to the dark & light mode
        view.backgroundColor = .systemBackground
        configureLogoImageView()
        configureTextField()
        configureCallToActionButton()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Hide the navigation bar
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    func configureLogoImageView() {
        view.addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        // Set the image
        logoImageView.image = UIImage(named: "gh-logo")!

        // Using array set the constraints programmatically
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: 80
            ),
            // Center the image horizontally
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            // Set the width and height of the image
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            logoImageView.widthAnchor.constraint(equalToConstant: 200),
        ])
    }

    func configureTextField() {
        view.addSubview(usernameTextField)
        // Set the constraints programmatically
        // Most of times 4 constraints are needed
        NSLayoutConstraint.activate([
            usernameTextField.topAnchor.constraint(
                equalTo: logoImageView.bottomAnchor,
                constant: 48
            ),
            usernameTextField.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 50
            ),
            usernameTextField.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -50 // Negative value for the trailing constraints
            ),
            usernameTextField.heightAnchor.constraint(equalToConstant: 50),
        ])
    }

    func configureCallToActionButton() {
        // Add the button to the view, equivalent to drag and drop in the storyboard
        view.addSubview(callToActionButton)
        // Set the constraints programmatically
        // Most of times 4 constraints are needed
        NSLayoutConstraint.activate([
            callToActionButton.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                constant: -50 // Negative value for the trailing & bottom constraints
            ),
            callToActionButton.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 50
            ),
            callToActionButton.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -50 // Negative value for the trailing & bottom constraints
            ),
            callToActionButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

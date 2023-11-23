//
//  SearchVC.swift
//  GitHubFollowers
//
//  Created by Māris Lakšs on 01/11/2023.
//

import UIKit

class SearchVC: UIViewController {
    let logoImageView       = UIImageView()
    let usernameTextField   = GFTextField()
    let callToActionButton  = GFButton(backgroundColor: .systemGreen, title: "Get Followers")

    // Computed property
    var isUsernameEntered: Bool {
        // Check if the text field is empty
        return !usernameTextField.text!.isEmpty
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Adapt the view to the dark & light mode
        view.backgroundColor = .systemBackground
        configureLogoImageView()
        configureTextField()
        configureCallToActionButton()
        createDismissKeyboardTapGesture()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Hide the navigation bar
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    func createDismissKeyboardTapGesture() {
        // Create a tap gesture recognizer
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        // Add the tap gesture recognizer to the overall view
        // Tap anywhere on the screen to dismiss the keyboard
        view.addGestureRecognizer(tap)
    }

    @objc func pushFollowerListVC() {
        guard isUsernameEntered else {
            presentGFAlertOnMainThread(
                title: "Empty Username",
                message: "Please enter a username. We need to know who to look for 😀.",
                buttonTitle: "OK"
            )
            return
        }

        let followerListVC      = FollowerListVC()
        // Set the username
        followerListVC.username = usernameTextField.text
        followerListVC.title    = usernameTextField.text
        // Push the view controller
        navigationController?.pushViewController(followerListVC, animated: true)
        // Dismiss the keyboard
        self.view.endEditing(true)
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
        // Set the delegate, so we can use the text field delegate methods
        usernameTextField.delegate = self

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
        // Add the target to the button
        callToActionButton.addTarget(
            self,
            action: #selector(pushFollowerListVC),
            for: .touchUpInside
        )

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
            callToActionButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
}

extension SearchVC: UITextFieldDelegate {
    // This method is called when the user taps the return button on the keyboard
    func textFieldShouldReturn(_: UITextField) -> Bool {
        pushFollowerListVC()
        return true
    }
}
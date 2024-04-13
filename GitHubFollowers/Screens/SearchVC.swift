//
//  SearchVC.swift
//  GitHubFollowers
//
//  Created by Māris Lakšs on 01/11/2023.
//

import UIKit

class SearchVC: UIViewController {
    let logoImageView      = UIImageView()
    let usernameTextField  = GFTextField()
    let callToActionButton = GFButton(backgroundColor: .systemGreen, title: "Get Followers")

    // Computed property
    var isUsernameEntered: Bool {
        // Check if the text field is empty
        !usernameTextField.text!.isEmpty
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Adapt the view to the dark & light mode
        view.backgroundColor = .systemBackground
        // Add the subviews to the view, this is equivalent to drag and drop in the storyboards
        view.addSubviews(logoImageView, usernameTextField, callToActionButton)

        // Call the configure methods & createDismissKeyboardTapGesture
        configureLogoImageView()
        configureTextField()
        configureCallToActionButton()
        createDismissKeyboardTapGesture()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        usernameTextField.text = ""
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
        // Dismiss the keyboard
        view.endEditing(true)

        let followerListVC = FollowerListVC(username: usernameTextField.text!)
        // Push the view controller
        navigationController?.pushViewController(followerListVC, animated: true)
    }

    func configureLogoImageView() {
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        // Set the image
        logoImageView.image = Images.ghLogo

        let topConstraintConstant: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? 20 : 80

        // Disable keyboard suggestions bar for usernameTextField
        usernameTextField.spellCheckingType = .no

        // Using array set the constraints programmatically
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: topConstraintConstant),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            logoImageView.widthAnchor.constraint(equalToConstant: 200)
        ])
    }

    func configureTextField() {
        // Set the delegate, so we can use the text field delegate methods
        usernameTextField.delegate = self

        // Set the constraints programmatically, most of times 4 constraints are needed
        NSLayoutConstraint.activate([
            usernameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48),
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            // Negative value for the trailing constraints
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            usernameTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    func configureCallToActionButton() {
        // Add the target to the button
        callToActionButton.addTarget(self, action: #selector(pushFollowerListVC), for: .touchUpInside)

        NSLayoutConstraint.activate([
            // Negative value for the trailing & bottom constraints
            callToActionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            callToActionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            callToActionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            callToActionButton.heightAnchor.constraint(equalToConstant: 50)
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

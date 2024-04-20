//
//  GFAlertVC.swift
//  GitHubFollowers
//
//  Created by Māris Lakšs on 13/11/2023.
//

import UIKit

// MARK: - GFAlertVC Class

// GFAlertVC is a subclass of UIViewController, it presents an alert to the user.
class GFAlertVC: UIViewController {

    // MARK: - Properties
    
    let containerView   = GFAlertContainerView()
    let titleLabel      = GFTitleLabel(textAlignment: .center, fontSize: 20)
    let messageLabel    = GFBodyLabel(textAlignment: .center)
    let actionButton    = GFButton(color: .systemPink, title: "OK", systemImageName: "checkmark.circle.fill")

    var alertTitle: String?
    var message: String?
    var buttonTitle: String?

    let padding: CGFloat = 20

    // Add Blur Effect View
    let blurEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .systemMaterial)
        let view = UIVisualEffectView(effect: blurEffect)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Initialization

    init(title: String, message: String, buttonTitle: String) {
        super.init(nibName: nil, bundle: nil)
        alertTitle          = title
        self.message        = message
        self.buttonTitle    = buttonTitle
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.75)
        view.addSubview(containerView)
        containerView.addSubviews(blurEffectView, titleLabel, actionButton, messageLabel)

        // Remember to call the configure methods
        configureBlurEffectView()
        configureContainerView()
        configureTitleLabel()
        configureActionButton()
        configureMessageLabel()
    }

    // MARK: - Configuration

    func configureContainerView() {
        // Add constraints
        NSLayoutConstraint.activate([
            // Center vertically
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            // Center horizontally
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            // Set the width
            containerView.widthAnchor.constraint(equalToConstant: 280),
            // Set the height
            containerView.heightAnchor.constraint(equalToConstant: 220)
        ])
    }


    // Add Blur Effect View when the alert is presented
    private func configureBlurEffectView() {
        NSLayoutConstraint.activate([
            blurEffectView.topAnchor.constraint(equalTo: view.topAnchor),
            blurEffectView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            blurEffectView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            blurEffectView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        // Set the alpha for the blur effect view
        blurEffectView.alpha = 0.75
    }


    func configureTitleLabel() {
        // Set the title text
        titleLabel.text = alertTitle ?? "Something went wrong"

        // Add constraints
        NSLayoutConstraint.activate([
            // Set the top anchor
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: padding),
            // Set the leading anchor (leading = left)
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            // Set the trailing anchor (trailing = right)
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            // Set the height
            titleLabel.heightAnchor.constraint(equalToConstant: 28)
        ])
    }


    func configureActionButton() {
        // Set the button title
        actionButton.setTitle(buttonTitle ?? "OK", for: .normal)

        // Add target
        actionButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)

        // Add constraints for the button
        NSLayoutConstraint.activate([
            // Set the bottom anchor
            actionButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -padding),
            // Set the leading anchor (leading = left)
            actionButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            // Set the trailing anchor (trailing = right)
            actionButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            // Set the height
            actionButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }


    func configureMessageLabel() {
        // Set the message text
        messageLabel.text           = message ?? "Unable to complete request"
        // Set the number of lines
        messageLabel.numberOfLines  = 4

        // Add constraints
        NSLayoutConstraint.activate([
            // Set the top anchor
            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            // Set the leading anchor (leading = left)
            messageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            // Set the trailing anchor (trailing = right)
            messageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            // Set the bottom anchor
            messageLabel.bottomAnchor.constraint(equalTo: actionButton.topAnchor, constant: -12)
        ])
    }

    // MARK: - Actions
    
    @objc func dismissVC() {
        dismiss(animated: true)
    }
}

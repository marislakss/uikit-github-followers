//
//  GFEmptyStateView.swift
//  GitHubFollowers
//
//  Created by Māris Lakšs on 26/11/2023.
//

import UIKit

// MARK: - GFEmptyStateView Class

// GFEmptyStateView is a subclass of UIView, it's a custom View used for presenting empty state screens.
class GFEmptyStateView: UIView {

    // MARK: - Properties
    
    let messageLabel  = GFTitleLabel(textAlignment: .center, fontSize: 28)
    let logoImageView = UIImageView()

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // Set the message label text
    convenience init(message: String) {
        self.init(frame: .zero)
        messageLabel.text = message
    }

    // MARK: - Configuration
    
    private func configure() {
        // Add messageLabel & logoImageView as a subviews to the instance
        // of the GFEmptyStateView (which is a subclass of UIView)
        addSubviews(messageLabel, logoImageView)
        // Call the configureMessageLabel() method
        configureMessageLabel()
        // Call the configureLogoImageView() method
        configureLogoImageView()
    }


    private func configureMessageLabel() {
        // Configure the message label
        messageLabel.numberOfLines = 3
        messageLabel.textColor     = .secondaryLabel

        //                                           IF            OR           IF      do -80 if true OR  do -150 if false
        let labelCenterYConstant: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? -80 : -150
        
        // Message label constraints
        NSLayoutConstraint.activate([
            messageLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: labelCenterYConstant),
            messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            messageLabel.heightAnchor.constraint(equalToConstant: 200)
        ])
    }

    
    private func configureLogoImageView() {
        // Configure the logo image view
        logoImageView.image = Images.emptyStateLogo
        logoImageView.translatesAutoresizingMaskIntoConstraints = false

        let logoBottomConstant: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? 80 : 40

        // Logo image view constraints
        NSLayoutConstraint.activate([
            logoImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1.3),
            logoImageView.heightAnchor.constraint(equalTo: logoImageView.widthAnchor),
            logoImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 170),
            logoImageView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: logoBottomConstant)
        ])
    }
}

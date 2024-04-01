//
//  GFEmptyStateView.swift
//  GitHubFollowers
//
//  Created by Māris Lakšs on 26/11/2023.
//

import UIKit

class GFEmptyStateView: UIView {
    let messageLabel = GFTitleLabel(textAlignment: .center, fontSize: 28)
    let logoImageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        // Call configure() the view method
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

    private func configure() {
        // Call the configureMessageLabel() method
        configureMessageLabel()
        // Call the configureLogoImageView() method
        configureLogoImageView()
    }

    private func configureMessageLabel() {
        // Add messageLabel as a subview to the instance of the GFEmptyStateView (which is a subclass of UIView)
        addSubview(messageLabel)
        // Configure the message label
        messageLabel.numberOfLines = 3
        messageLabel.textColor = .secondaryLabel

        //                                           IF            OR           IF      do -80 if true OR  do -150 if false
        let labelCenterYConstant: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? -80 : -150

        let messageLabelCenterYConstant = messageLabel.centerYAnchor.constraint(
            equalTo: centerYAnchor,
            constant: labelCenterYConstant
        )
        messageLabelCenterYConstant.isActive = true
        
        // Message label constraints
        NSLayoutConstraint.activate([
            messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            messageLabel.heightAnchor.constraint(equalToConstant: 200)
        ])
    }

    private func configureLogoImageView() {
        // Add logoImageView as a subview to the instance of the GFEmptyStateView (which is a subclass of UIView)
        addSubview(logoImageView)
        // Configure the logo image view
        logoImageView.image = Images.emptyStateLogo
        logoImageView.translatesAutoresizingMaskIntoConstraints = false

        let logoBottomConstant: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? 80 : 40

        let logoImageViewBottomConstraint = logoImageView.bottomAnchor.constraint(
            equalTo: bottomAnchor,
            constant: logoBottomConstant
        )
        logoImageViewBottomConstraint.isActive = true

        // Logo image view constraints
        NSLayoutConstraint.activate([
            logoImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1.3),
            logoImageView.heightAnchor.constraint(equalTo: logoImageView.widthAnchor),
            logoImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 170)
        ])
    }
}

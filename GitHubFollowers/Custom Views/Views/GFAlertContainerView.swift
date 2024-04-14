//
//  GFAlertContainerView.swift
//  GitHubFollowers
//
//  Created by Māris Lakšs on 17/11/2023.
//

import UIKit

class GFAlertContainerView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    private func configure() {
        // Set the background color
        backgroundColor     = .systemBackground
        // Set the corner radius
        layer.cornerRadius  = 16
        // Add white border around container view for Dark mode
        layer.borderWidth   = 2
        layer.borderColor   = UIColor.white.cgColor
        // Set the shadow
        layer.shadowColor   = UIColor.black.cgColor
        layer.shadowOpacity = 0.6
        layer.shadowOffset  = CGSize(width: 0, height: 4)
        layer.shadowRadius  = 16
        // Set the autoresizing mask
        translatesAutoresizingMaskIntoConstraints = false
    }
}

//
//  GFSecondaryTitleLabel.swift
//  GitHubFollowers
//
//  Created by Māris Lakšs on 30/11/2023.
//

import UIKit

// MARK: - GFSecondaryTitleLabel Class

// GFSecondaryTitleLabel is a subclass of UILabel, providing a reusable
// styled secondary title label for the application.
class GFSecondaryTitleLabel: UILabel {

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    // This initializer is used when creating a GFSecondaryTitleLabel from a storyboard.
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // This initializer accepts a font size, and creates a GFSecondaryTitleLabel with this property.
    convenience init(fontSize: CGFloat) {
        self.init(frame: .zero)
        // Set the font size and weight
        font = UIFont.systemFont(ofSize: fontSize, weight: .medium)
    }

    // MARK: - Configuration
    
    // Configure the default properties for the GFSecondaryTitleLabel.
    private func configure() {
        textColor                   = .secondaryLabel
        adjustsFontSizeToFitWidth   = true
        minimumScaleFactor          = 0.90
        lineBreakMode               = .byTruncatingTail
        // Use Auto Layout
        translatesAutoresizingMaskIntoConstraints = false
    }
}

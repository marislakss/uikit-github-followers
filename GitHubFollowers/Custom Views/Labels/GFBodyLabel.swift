//
//  GFBodyLabel.swift
//  GitHubFollowers
//
//  Created by Māris Lakšs on 13/11/2023.
//

import UIKit

// MARK: - GFBodyLabel Class

// GFBodyLabel is a subclass of UILabel, providing a reusable styled body label for the application.
class GFBodyLabel: UILabel {

    // MARK: - Initialization

    // Initializer used when creating a GFBodyLabel programmatically.
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    // Initializer used when creating a GFBodyLabel from a storyboard.
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Initializer accepts a text alignment, and creates a GFBodyLabel with this property.
    convenience init(textAlignment: NSTextAlignment) {
        self.init(frame: .zero)
        // Set the text alignment
        self.textAlignment = textAlignment
    }

    // MARK: - Configuration

    // Method to configure default properties for the GFBodyLabel.
    private func configure() {
        // Set the color
        textColor                         = .secondaryLabel
        // Set the text font
        font                              = UIFont.preferredFont(forTextStyle: .body)
        // Set BodyLabel to work with dynamic type
        adjustsFontForContentSizeCategory = true
        // Set the font to scale to fit the width of the label
        adjustsFontSizeToFitWidth         = true
        // Set minimum scale factor
        minimumScaleFactor                = 0.75
        // Set the line break mode
        lineBreakMode                     = .byWordWrapping
        // Set constraints
        translatesAutoresizingMaskIntoConstraints = false
    }
}

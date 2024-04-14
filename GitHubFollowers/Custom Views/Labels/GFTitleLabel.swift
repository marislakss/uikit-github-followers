//
//  GFTitleLabel.swift
//  GitHubFollowers
//
//  Created by Māris Lakšs on 07/11/2023.
//

import UIKit

class GFTitleLabel: UILabel {
    // Designated (custom) initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Convenience initializer with text alignment and font size
    convenience init(textAlignment: NSTextAlignment, fontSize: CGFloat) {
        self.init(frame: .zero)
        // Set the text alignment
        self.textAlignment = textAlignment
        // Set the font size
        self.font = UIFont.systemFont(ofSize: fontSize, weight: .bold)
    }


    private func configure() {
        // Set the color
        textColor                 = .label
        // Set the minimum scale factor
        adjustsFontSizeToFitWidth = true
        // Set minimum scale factor
        minimumScaleFactor        = 0.9
        // Set the line break mode
        lineBreakMode             = .byTruncatingTail
        // Set constraints
        translatesAutoresizingMaskIntoConstraints = false
    }
}

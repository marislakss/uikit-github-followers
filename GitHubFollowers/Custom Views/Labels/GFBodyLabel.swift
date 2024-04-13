//
//  GFBodyLabel.swift
//  GitHubFollowers
//
//  Created by Māris Lakšs on 13/11/2023.
//

import UIKit

class GFBodyLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(textAlignment: NSTextAlignment) {
        self.init(frame: .zero)
        // Set the text alignment
        self.textAlignment = textAlignment
    }

    private func configure() {
        // Set the color
        textColor                         = .secondaryLabel
        // Set the text font
        font                              = UIFont.preferredFont(forTextStyle: .body)
        // Set BodyLabel to work with dynamic type
        adjustsFontForContentSizeCategory = true
        // Set the minimum scale factor
        adjustsFontSizeToFitWidth         = true
        // Set minimum scale factor
        minimumScaleFactor                = 0.75
        // Set the line break mode
        lineBreakMode                     = .byWordWrapping
        // Set constraints
        translatesAutoresizingMaskIntoConstraints = false
    }
}

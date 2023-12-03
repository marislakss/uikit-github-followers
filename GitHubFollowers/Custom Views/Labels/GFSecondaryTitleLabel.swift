//
//  GFSecondaryTitleLabel.swift
//  GitHubFollowers
//
//  Created by Māris Lakšs on 30/11/2023.
//

import UIKit

class GFSecondaryTitleLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    // This initializer is called when we create a label from storyboard
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // This initializer is called when we create a label from code
    init(fontSize: CGFloat) {
        super.init(frame: .zero)
        // Set the font size and weight
        font = UIFont.systemFont(ofSize: fontSize, weight: .medium)
        configure()
    }

    private func configure() {
        // This is a dynamic color
        textColor = .secondaryLabel
        // This will make the font size smaller if the text is too long
        adjustsFontSizeToFitWidth = true
        // This is the minimum size of the font
        minimumScaleFactor = 0.90
        // This will truncate the text if it is too long
        lineBreakMode = .byTruncatingTail
        // This will allow us to use autolayout
        translatesAutoresizingMaskIntoConstraints = false
    }
}

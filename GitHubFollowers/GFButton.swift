//
//  GFButton.swift
//  GitHubFollowers
//
//  Created by Māris Lakšs on 05/11/2023.
//

import UIKit

class GFButton: UIButton {
    override init(frame: CGRect) {
        // super.init(frame: frame) calls the init of the parent class and obtain
        // all the properties of the parent class
        super.init(frame: frame)

        configure()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(backgroundColor: UIColor, title: String) {
        super.init(frame: .zero)

        self.backgroundColor = backgroundColor
        setTitle(title, for: .normal)
        configure()
    }

    // MARK: - Private methods

    private func configure() {
        layer.cornerRadius = 10
        titleLabel?.textColor = .white
        // Use Apple's dynamic type to adjust the font size
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        // Use auto layout
        translatesAutoresizingMaskIntoConstraints = false
    }
}

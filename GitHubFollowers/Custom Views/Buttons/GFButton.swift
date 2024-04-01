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

    convenience init(backgroundColor: UIColor, title: String) {
        self.init(frame: .zero)
        self.backgroundColor = backgroundColor
        setTitle(title, for: .normal)
    }

    // MARK: - Private methods

    private func configure() {
        layer.cornerRadius = 10
        // Set the button's title color to white
        setTitleColor(.white, for: .normal)
        // Use Apple's dynamic type to adjust the font size
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        // Use auto layout
        translatesAutoresizingMaskIntoConstraints = false
    }

    func set(backgroundColor: UIColor, title: String) {
        self.backgroundColor = backgroundColor
        setTitle(title, for: .normal)
    }
}

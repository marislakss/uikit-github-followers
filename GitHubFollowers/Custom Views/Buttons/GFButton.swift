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

    convenience init(color: UIColor, title: String, systemImageName: String) {
        self.init(frame: .zero)
        set(color: color, title: title, systemImageName: systemImageName)
    }


    private func configure() {
        configuration = .tinted()
        configuration?.cornerStyle = .medium
        // Use auto layout
        translatesAutoresizingMaskIntoConstraints = false
    }

    
    func set(color: UIColor, title: String, systemImageName: String) {
        configuration?.baseBackgroundColor = color
        configuration?.baseForegroundColor = color
        configuration?.title = title

        configuration?.image = UIImage(systemName: systemImageName)
        configuration?.imagePadding = 6
        configuration?.imagePlacement = .leading
    }
}

// Use this #Preview macro syntax to preview the button in the canvas
#Preview {
    return GFButton(color: .blue, title: "Test Button", systemImageName: "pencil.circle.fill")
}

//
//  GFTextField.swift
//  GitHubFollowers
//
//  Created by Māris Lakšs on 05/11/2023.
//

import UIKit

class GFTextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false

        layer.cornerRadius        = 10
        layer.borderWidth         = 2
        layer.borderColor         = UIColor.systemGray4.cgColor

        textColor                 = .label
        tintColor                 = .label
        textAlignment             = .center
        // Use Dynamic Type
        font                      = UIFont.preferredFont(forTextStyle: .title2)
        adjustsFontSizeToFitWidth = true
        minimumFontSize           = 12

        backgroundColor           = .tertiarySystemBackground
        // Having different types of usernames turn off autocorrect for this text field
        autocorrectionType        = .no
        // In case you would need to implement different types of keyboards use keyboardType
        // keyboardType              = .numberPad
        placeholder               = "Enter a username"
        returnKeyType             = .go
        // Add a clear button to the text field
        clearButtonMode           = .whileEditing
    }
}

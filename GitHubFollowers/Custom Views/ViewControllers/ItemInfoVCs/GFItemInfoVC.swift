//
//  GFItemInfoVC.swift
//  GitHubFollowers
//
//  Created by Māris Lakšs on 04/12/2023.
//

import UIKit

// Create superclass (parent) item info view controller
class GFItemInfoVC: UIViewController {

    let stackView = UIStackView()
    let itemInfoViewOne = GFItemInfoView()
    let itemInfoViewTwo = GFItemInfoView()
    let actionButton = GFButton()

    var user: User!

    // Custom initializer
    init(user: User) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }

    // Required initializer
    required init?(coder: NSCoder) { 
        fatalError("init(coder:) has not been implemented") 
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureBackgroundView()
        layoutUI()
        configureStackView()
    }

    func configureBackgroundView() {
        view.layer.cornerRadius = 18
        view.backgroundColor = .secondarySystemBackground
    }

    private func configureStackView() {
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing

        stackView.addArrangedSubview(itemInfoViewOne)
        stackView.addArrangedSubview(itemInfoViewTwo)
    }

    private func layoutUI() {
        view.addSubview(stackView)
        view.addSubview(actionButton)

        let padding: CGFloat = 20

        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            stackView.heightAnchor.constraint(equalToConstant: 50),

            actionButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),
            actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            actionButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
}

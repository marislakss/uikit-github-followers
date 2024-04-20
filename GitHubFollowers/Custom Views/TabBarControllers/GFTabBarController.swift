//
//  GFTabBarController.swift
//  GitHubFollowers
//
//  Created by Māris Lakšs on 29/03/2024.
//

import UIKit

// MARK: - GFTabBarController Class

class GFTabBarController: UITabBarController {

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        // Set the color of the tab bar items.
        UITabBar.appearance().tintColor = .systemGreen
        // Create and set the view controllers for the tabs.
        viewControllers                 = [createSearchNC(), createFavoritesNC()]
    }

    // MARK: - Navigation Controllers
    
    // This method creates and returns a UINavigationController with a SearchVC as its root view controller.
    func createSearchNC() -> UINavigationController {
        let searchVC        = SearchVC()
        searchVC.title      = "Search"
        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)

        return UINavigationController(rootViewController: searchVC)
    }

    // This method creates and returns a UINavigationController with a FavoritesListVC as its root view controller.
    func createFavoritesNC() -> UINavigationController {
        let favoritesListVC        = FavoritesListVC()
        favoritesListVC.title      = "Favorites"
        favoritesListVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)

        return UINavigationController(rootViewController: favoritesListVC)
    }
}

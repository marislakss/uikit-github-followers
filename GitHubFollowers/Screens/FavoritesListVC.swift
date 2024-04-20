//
//  FavouritesListVC.swift
//  GitHubFollowers
//
//  Created by Māris Lakšs on 01/11/2023.
//

import UIKit

// FavoritesListVC is a subclass of GFDataLoadingVC superclass
class FavoritesListVC: GFDataLoadingVC {
    let tableView             = UITableView()
    var favorites: [Follower] = []


    override func viewDidLoad() {
        super.viewDidLoad()

        configureViewController()
        configureTableView()

        navigationController?.isNavigationBarHidden = false
    }


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFavorites()
    }

    // New function for default empty state view 
    override func updateContentUnavailableConfiguration(using state: UIContentUnavailableConfigurationState) {
        // If you don't have any favorites, show the content unavailable view
        if favorites.isEmpty {
            var config = UIContentUnavailableConfiguration.empty()
            config.image = .init(systemName: "star.fill")
            config.text = "No Favorites"
            config.secondaryText = "Add a Favorite on the follower screen."
            contentUnavailableConfiguration = config
        } else {
            // If you have favorites, don't show the content unavailable view
            contentUnavailableConfiguration = nil
        }
    }


    func configureViewController() {
        view.backgroundColor = .systemBackground
        title                = "Favorites"
        navigationController?.navigationBar.prefersLargeTitles = true
    }


    func configureTableView() {
        view.addSubview(tableView)

        tableView.frame      = view.bounds
        tableView.rowHeight  = 80
        tableView.delegate   = self
        tableView.dataSource = self
        tableView.removeExcessCells()

        tableView.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.reuseID)
    }


    func getFavorites() {
        PersistenceManager.retrieveFavorites { [weak self] result in
            guard let self else { return }

            switch result {
            case .success(let favorites):
                self.updateUI(with: favorites)

            case .failure(let error):
                DispatchQueue.main.async {
                    self.presentGFAlert(
                        title: "Something went wrong",
                        message: error.rawValue,
                        buttonTitle: "OK"
                    )
                }
            }
        }
    }


    func updateUI(with favorites: [Follower]) {
        self.favorites = favorites
        setNeedsUpdateContentUnavailableConfiguration()
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.view.bringSubviewToFront(self.tableView)
        }
    }
}

extension FavoritesListVC: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell     = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.reuseID) as! FavoriteCell
        let favorite = favorites[indexPath.row]
        cell.set(favorite: favorite)
        return cell
    }


    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favorite = favorites[indexPath.row]
        let destVC   = FollowerListVC(username: favorite.login)

        navigationController?.pushViewController(destVC, animated: true)
    }

    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }

        PersistenceManager.updateWith(favorite: favorites[indexPath.row], actionType: .remove) { [weak self] error in
            guard let self else { return }
            
            guard let error else {
                self.favorites.remove(at: indexPath.row)
                // To be safe, delete rows while on the main thread
                DispatchQueue.main.async {
                    tableView.deleteRows(at: [indexPath], with: .left)
                    self.setNeedsUpdateContentUnavailableConfiguration()
                }
                return
            }
            
            DispatchQueue.main.async {
                self.presentGFAlert(title: "Unable to remove", message: error.rawValue, buttonTitle: "OK")
            }
        }
    }
}

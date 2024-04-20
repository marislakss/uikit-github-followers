//
//  PersistenceManager.swift
//  GitHubFollowers
//
//  Created by Māris Lakšs on 24/03/2024.
//

import Foundation

// MARK: - PersistenceActionType Enum

// Defines the types of persistence actions that can be performed.
enum PersistenceActionType {
    case add, remove
}

// MARK: - PersistenceManager Enum

// Manages persistence of favorite followers using UserDefaults.
enum PersistenceManager {

    // MARK: - Properties

    private static let defaults = UserDefaults.standard

    // MARK: - Keys Enum

    // Stores UserDefaults keys to avoid hard-coded strings throughout the app.
    enum Keys { static let favorites = "favorites" }

    // MARK: - Update Favorites

    // Updates the list of favorite followers in UserDefaults based on the action type.
    static func updateWith(
        favorite: Follower,
        actionType: PersistenceActionType,
        // Completion handler to return an error if there is one
        completed: @escaping (GFError?) -> Void
    ) {
        retrieveFavorites { result in
            switch result {
            case .success(var favorites):

                switch actionType {
                case .add:
                    // Check if the favorite is already in the list.
                    guard !favorites.contains(favorite) else {
                        completed(.alreadyInFavorites)
                        return
                    }
                    // If not, add the favorite to the list.
                    favorites.append(favorite)

                case .remove:
                    // Remove all instances of favorite from the list
                    // $0 is a shorthand for each element in the array
                    favorites.removeAll { $0.login == favorite.login }
                }
                // Save updated list of favorites to UserDefaults
                completed(save(favorites: favorites))

            case .failure(let error):
                completed(error)
            }
        }
    }

    // MARK: - Retrieve Favorites

    // Retrieves the list of favorite followers from UserDefaults.
    static func retrieveFavorites(completed: @escaping (Result<[Follower], GFError>) -> Void) {
        guard let favoritesData = defaults.object(forKey: Keys.favorites) as? Data else {
            completed(.success([]))
            return
        }

        do {
            // When retrieving data from UserDefaults, we need to decode it.
            let decoder   = JSONDecoder()
            let favorites = try decoder.decode([Follower].self, from: favoritesData)
            completed(.success(favorites))
        } catch {
            completed(.failure(.unableToFavorite))
        }
    }

    // MARK: - Save Favorites

    // Saves the list of favorite followers to UserDefaults.
    static func save(favorites: [Follower]) -> GFError? {
        do {
            // When saving data to UserDefaults, we need to encode it.
            let encoder          = JSONEncoder()
            let encodedFavorites = try encoder.encode(favorites)
            // Save encoded data to UserDefaults
            defaults.set(encodedFavorites, forKey: Keys.favorites)
            return nil
        } catch {
            return .unableToFavorite
        }
    }
}

//
//  PersistenceManager.swift
//  GitHubFollowers
//
//  Created by Māris Lakšs on 24/03/2024.
//

import Foundation

// Enum for adding or removing a favorite
enum PersistenceActionType {
    case add, remove
}

// Enum for managing UserDefaults
enum PersistenceManager {
    private static let defaults = UserDefaults.standard

    // Enum for managing UserDefaults keys
    enum Keys {
        static let favorites = "favorites"
    }

    // Function to update favorites in UserDefaults
    static func updateWith(
        favorite: Follower,
        actionType: PersistenceActionType,
        // Completion handler to return an error if there is one
        completed: @escaping (GFError?) -> Void
    ) {
        retrieveFavorites { result in
            switch result {
            case let .success(favorites):
                var retrievedFavorites = favorites

                switch actionType {
                case .add:
                    // Check if the favorite is already in the list
                    guard !retrievedFavorites.contains(favorite) else {
                        completed(.alreadyInFavorites)
                        return
                    }
                    // If not, add the favorite to the list
                    retrievedFavorites.append(favorite)

                case .remove:
                    // Remove all instances of favorite from the list
                    // $0 is a shorthand for each element in the array
                    retrievedFavorites.removeAll { $0.login == favorite.login }
                }

                // Save updated list of favorites to UserDefaults
                completed(save(favorites: retrievedFavorites))

            case let .failure(error):
                completed(error)
            }
        }
    }

    // Function to retrieve favorites from UserDefaults
    static func retrieveFavorites(completed: @escaping (Result<[Follower], GFError>) -> Void) {
        guard let favoritesData = defaults.object(forKey: Keys.favorites) as? Data else {
            completed(.success([]))
            return
        }

        do {
            // When retrieving data from UserDefaults, we need to decode it.
            let decoder = JSONDecoder()
            let favorites = try decoder.decode([Follower].self, from: favoritesData)
            completed(.success(favorites))
        } catch {
            completed(.failure(.unableToFavorite))
        }
    }

    // Function to save favorites to UserDefaults
    static func save(favorites: [Follower]) -> GFError? {
        do {
            // When saving data to UserDefaults, we need to encode it.
            let encoder = JSONEncoder()
            let encodedFavorites = try encoder.encode(favorites)
            // Save encoded data to UserDefaults
            defaults.set(encodedFavorites, forKey: Keys.favorites)
            return nil
        } catch {
            return .unableToFavorite
        }
    }
}

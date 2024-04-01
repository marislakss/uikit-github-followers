//
//  NetworkManager.swift
//  GitHubFollowers
//
//  Created by Māris Lakšs on 21/11/2023.
//

import UIKit

class NetworkManager {
    static let shared = NetworkManager()
    private let baseURL = "https://api.github.com/users/"
    let cache = NSCache<NSString, UIImage>()

    private init() {}

    func getFollowers(
        for username: String,
        page: Int,
        completed: @escaping (Result<[Follower], GFError>) -> Void
    ) {
        let endpoint = baseURL + "\(username)/followers?per_page=100&page=\(page)"

        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidUsername))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }

            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }

            guard let data else {
                completed(.failure(.invalidData))
                return
            }

            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([Follower].self, from: data)
                completed(.success(followers))
            } catch {
                print("Error decoding User: \(error)")
                completed(.failure(.invalidData))
            }
        }
        // Start Network Call
        task.resume()
    }

    func getUserInfo(
        for username: String,
        completed: @escaping (Result<User, GFError>) -> Void
    ) {
        let endpoint = baseURL + "\(username)"

        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidUsername))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }

            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }

            guard let data else {
                completed(.failure(.invalidData))
                return
            }

            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                decoder.dateDecodingStrategy = .iso8601
                let user = try decoder.decode(User.self, from: data)
                completed(.success(user))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        // Start Network Call
        task.resume()
    }

    func downloadImage(from urlString: String, completed: @escaping (UIImage?) -> Void) {
        // If cached image is available, return
        let cacheKey = NSString(string: urlString)

        if let image = cache.object(forKey: cacheKey) {
            completed(image)
            return
        }

        // If cached image is not available, do the network call to download it
        // Create the URL
        guard let url = URL(string: urlString) else {
            // If url is invalid, return nil
            completed(nil)
            return
        }

        // Create the URL session
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self,
                  error == nil,
                  let response = response as? HTTPURLResponse, response.statusCode == 200,
                  let data,
                  let image = UIImage(data: data) else {
                completed(nil)
                // All guard statements must include a return statement
                return
            }
            // Set the image to the cache
            self.cache.setObject(image, forKey: cacheKey)

            completed(image)
        }
        // Start the task
        task.resume()
    }
}

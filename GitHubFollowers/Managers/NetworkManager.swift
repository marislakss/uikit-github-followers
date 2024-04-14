//
//  NetworkManager.swift
//  GitHubFollowers
//
//  Created by Māris Lakšs on 21/11/2023.
//

import UIKit

class NetworkManager {
    static let shared   = NetworkManager()
    private let baseURL = "https://api.github.com/users/"
    let cache           = NSCache<NSString, UIImage>()
    let decoder         = JSONDecoder()

    private init() {
        decoder.keyDecodingStrategy  = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
    }
    
    // Network Call using async/await
    func getFollowers(for username: String, page: Int) async throws -> [Follower] {
        // Create the endpoint
        let endpoint  = baseURL + "\(username)/followers?per_page=100&page=\(page)"
        
        // Check if the endpoint is valid, if that fails throw an error
        guard let url = URL(string: endpoint) else {
            throw GFError.invalidUsername
        }

        // await returns a tuple with data & response which are not optionals
        let(data, response) = try await URLSession.shared.data(from: url)

        // If have response, check the response code, if that fails throw an error
        // Cast response to HTTPURLResponse & response becomes an optional
        guard let response  = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw GFError.invalidResponse
        }

        do {
            // Decode array of followers from the data
            return try decoder.decode([Follower].self, from: data)
        } catch {
            // If unsuccessful, throw an error
            throw GFError.invalidData
        }
    }


    func getUserInfo(for username: String) async throws -> User {
        let endpoint  = baseURL + "\(username)"

        guard let url = URL(string: endpoint) else {
            throw GFError.invalidUsername
        }

        let(data, response) = try await URLSession.shared.data(from: url)

        guard let response  = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw GFError.invalidResponse
        }

        do {
            return try decoder.decode(User.self, from: data)
        } catch {
            throw GFError.invalidData
        }
    }


    func downloadImage(from urlString: String, completed: @escaping (UIImage?) -> Void) {
        let cacheKey = NSString(string: urlString)
        
        // If cached image is available, return
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
                  let data = data,
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

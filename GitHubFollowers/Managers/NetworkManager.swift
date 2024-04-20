//
//  NetworkManager.swift
//  GitHubFollowers
//
//  Created by Māris Lakšs on 21/11/2023.
//

import UIKit

// MARK: - NetworkManager Class

// The NetworkManager is a singleton class that handles all network requests for the GitHubFollowers app.
class NetworkManager {

    // MARK: - Properties

    static let shared   = NetworkManager()
    private let baseURL = "https://api.github.com/users/"
    let cache           = NSCache<NSString, UIImage>()
    let decoder         = JSONDecoder()

    private init() {
        decoder.keyDecodingStrategy  = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
    }
    
    // MARK: - Network Calls

    // Fetches followers for a specific GitHub user asynchronously.
    func getFollowers(for username: String, page: Int) async throws -> [Follower] {
        // Create the endpoint.
        let endpoint  = baseURL + "\(username)/followers?per_page=100&page=\(page)"
        
        // Check if the endpoint is valid, if that fails throw an error.
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


    // Fetches detailed user information asynchronously.
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

    
    // Downloads an image asynchronously from a URL string
    func downloadImage(from urlString: String) async -> UIImage? {
        let cacheKey = NSString(string: urlString)
        
        // If cached image is available, return image
        if let image = cache.object(forKey: cacheKey) { return image }

        // If cached image is not available, do the network call to download it
        // Create the URL                      if url is invalid, return nil
        guard let url = URL(string: urlString) else { return nil}
        
        do {
            // Create the URL session
            let (data, _) = try await URLSession.shared.data(from: url)

            // Get the image from the data, else return nil
            guard let image = UIImage(data: data) else { return nil }

            // Set the image to the cache
            cache.setObject(image, forKey: cacheKey)
            // Show the image
            return image
        } catch {
            return nil
        }
    }
}

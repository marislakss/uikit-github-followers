//
//  User.swift
//  GitHubFollowers
//
//  Created by Māris Lakšs on 18/11/2023.
//

import Foundation

// MARK: - User Model

// Represents a GitHub user, conforming to Codable for serialization and Hashable for use in collections.
struct User: Codable, Hashable {
    let login: String
    let avatarUrl: String
    // If some details on GitHub are optional, make sure to make them optional here as well.
    var name: String?
    var location: String?
    var bio: String?
    let publicRepos: Int
    let publicGists: Int
    let htmlUrl: String
    let following: Int
    let followers: Int
    let createdAt: Date
}

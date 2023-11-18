//
//  User.swift
//  GitHubFollowers
//
//  Created by Māris Lakšs on 18/11/2023.
//

import Foundation

struct User: Codable, Hashable {
    let login: String
    let avatarUrl: String
    // If some details on GitHub are optional, make sure to make them optional here as well.
    let name: String?
    let location: String?
    let bio: String?
    let publicRepos: Int
    let publicGists: Int
    let htmlUrl: String
    let following: Int
    let followers: Int
    let createdAt: Date
}

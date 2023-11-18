//
//  Follower.swift
//  GitHubFollowers
//
//  Created by Māris Lakšs on 18/11/2023.
//

import Foundation

struct Followers: Codable, Hashable {
    let login: String
    // You can replace avatar_url with camel case avatarUrl
    let avatarUrl: String
}

/*
 Question: Why do we use structs and not classes?
 Answer:   They are lighter and more performant. A rule of thumb is that if you don't need
           inheritance for an object, you should use a struct.
 */

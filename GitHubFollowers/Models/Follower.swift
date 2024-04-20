//
//  Follower.swift
//  GitHubFollowers
//
//  Created by Māris Lakšs on 18/11/2023.
//

import Foundation

// MARK: - Follower Model

// A lightweight model representing a follower, conforming to Codable and Hashable for easy encoding,
// decoding, and use in collections.
struct Follower: Codable, Hashable {
    let login: String
    // You can replace avatar_url with camel case avatarUrl
    let avatarUrl: String
}

/*
Question: Why do we use structs and not classes?
Answer:   Structs are typically used for modeling data that doesn't require inheritance.
          They are value types, which makes them safer and more performant in many cases
          because they are copied rather than referenced. A rule of thumb is that if you
          don't need inheritance for an object, you should use a struct. This avoids
          the overhead associated with reference types like classes, such as reference counting.
          Additionally, structs automatically receive synthesized initializers based on their properties,
          which simplifies their usage when initializing with data.
*/

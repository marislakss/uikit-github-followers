//
//  ErrorMessage.swift
//  GitHubFollowers
//
//  Created by Māris Lakšs on 23/11/2023.
//

import Foundation

// MARK: - GFError Enum

// `GFError` defines all the error types that the application can encounter in various operations,
// particularly during network calls and data handling processes. Each error type has a specific message
// associated with it, which can be displayed to the user.
enum GFError: String, Error {
    case invalidUsername    = "This username created an invalid request. Please try again."
    case unableToComplete   = "Unable to complete your request. Please check your internet connection."
    case invalidResponse    = "Invalid response from the server. Please try again."
    case invalidData        = "The data received from the server was invalid. Please try again."
    case unableToFavorite   = "Unable to add this user to favorites list. Please try again."
    case alreadyInFavorites = "This user is already in your favorites list."
}

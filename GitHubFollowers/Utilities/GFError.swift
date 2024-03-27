//
//  ErrorMessage.swift
//  GitHubFollowers
//
//  Created by Māris Lakšs on 23/11/2023.
//

import Foundation

enum GFError: String, Error {
    case invalidUsername    = "This username created an invalid request. Please try again."
    case unableToComplete   = "Unable to complete your request. Please check your internet connection."
    case invalidResponse    = "Invalid response from the server. Please try again."
    case invalidData        = "The data received from the server was invalid. Please try again."
    case unableToFavorite   = "Unable to add this user to favorites list. Please try again."
    case alreadyInFavorites = "This user is already in your favorites list."
}

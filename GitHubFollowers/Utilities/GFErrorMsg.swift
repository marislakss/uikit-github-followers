//
//  ErrorMessage.swift
//  GitHubFollowers
//
//  Created by Māris Lakšs on 23/11/2023.
//

import Foundation

enum GFErrorMsg: String {
    case invalidUsername    = "This username created an invalid request. Please try again."
    case unableToComplete   = "Unable to complete your request. Please check your internet connection."
    case invalidResponse    = "Invalid response from the server. Please try again."
    case invalidData        = "The data received from the server was invalid. Please try again."
}

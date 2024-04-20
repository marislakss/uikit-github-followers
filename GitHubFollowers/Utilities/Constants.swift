//
//  Constants.swift
//  GitHubFollowers
//
//  Created by Māris Lakšs on 30/11/2023.
//

import UIKit

// MARK: - SFSymbols

// Provides a centralized location for managing system image symbols used throughout the app.
enum SFSymbols {
    static let location                 = UIImage(systemName: "mappin.and.ellipse")
    static let repos                    = UIImage(systemName: "folder")
    static let gists                    = UIImage(systemName: "text.alignleft")
    static let followers                = UIImage(systemName: "heart")
    static let following                = UIImage(systemName: "person.2")
}

// MARK: - Images

// Manages custom images used across the application, ensuring consistency and easy maintenance.
enum Images {
    static let placeholder              = UIImage(resource: .avatarPlaceholder)
    static let ghLogo                   = UIImage(resource: .ghLogo)
    static let emptyStateLogo           = UIImage(resource: .emptyStateLogo)
}

// MARK: - ScreenSize

// Contains constants related to the device's screen dimensions, aiding responsive layout design.
enum ScreenSize {
    static let width                    = UIScreen.main.bounds.size.width
    static let height                   = UIScreen.main.bounds.size.height
    static let maxLength                = max(ScreenSize.width, ScreenSize.height)
    static let minLength                = min(ScreenSize.width, ScreenSize.height)
}

// MARK: - DeviceTypes

// Provides properties and utility functions to determine current device type and characteristics.
enum DeviceTypes {
    static let idiom                    = UIDevice.current.userInterfaceIdiom
    static let nativeScale              = UIScreen.main.nativeScale
    static let scale                    = UIScreen.main.scale

    static let isiPhoneSE               = idiom == .phone && ScreenSize.maxLength == 568.0
    static let isiPhone8Standard        = idiom == .phone && ScreenSize.maxLength == 667.0 && nativeScale == scale
    static let isiPhone8Zoomed          = idiom == .phone && ScreenSize.maxLength == 667.0 && nativeScale > scale
    static let isiPhone8PlusStandard    = idiom == .phone && ScreenSize.maxLength == 736.0
    static let isiPhone8PlusZoomed      = idiom == .phone && ScreenSize.maxLength == 736.0 && nativeScale < scale
    static let isiPhoneX                = idiom == .phone && ScreenSize.maxLength == 812.0
    static let isiPhoneXsMaxAndXr       = idiom == .phone && ScreenSize.maxLength == 896.0
    static let isiPad                   = idiom == .pad && ScreenSize.maxLength >= 1024.0

    
    // Determines if the current device has an aspect ratio similar to iPhone X models.
    static func isiPhoneXAspectRatio() -> Bool {
        return isiPhoneX || isiPhoneXsMaxAndXr
    }
}

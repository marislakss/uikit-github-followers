//
//  Date+Ext.swift
//  GitHubFollowers
//
//  Created by Māris Lakšs on 05/12/2023.
//

import Foundation

// MARK: - Date Extension

// This extension enhances the Date class by adding a method to format
// dates into a month and year string.
extension Date {

    // New iOS 15 syntax to format date
    func convertToMonthYearFormat() -> String { formatted(.dateTime.month().year()) }
}

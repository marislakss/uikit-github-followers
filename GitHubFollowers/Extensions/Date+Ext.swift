//
//  Date+Ext.swift
//  GitHubFollowers
//
//  Created by Māris Lakšs on 05/12/2023.
//

import Foundation

extension Date {
    func convertToMonthYearFormat() -> String {
        // Create a date formatter
        let dateFormatter = DateFormatter()
        // Set the date format
        dateFormatter.dateFormat = "MMM yyyy"

        // Return the date
        return dateFormatter.string(from: self)
    }
}

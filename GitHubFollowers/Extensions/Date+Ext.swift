//
//  Date+Ext.swift
//  GitHubFollowers
//
//  Created by Māris Lakšs on 05/12/2023.
//

import Foundation

extension Date {
    
//    // This function will convert the date to a string,
//    func convertToMonthYearFormat() -> String {
//        // Create a date formatter
//        let dateFormatter = DateFormatter()
//        // Set the date format
//        dateFormatter.dateFormat = "MMM yyyy"
//        // Return the date
//        return dateFormatter.string(from: self)
//    }

    // New iOS 15 way to format date
    func convertToMonthYearFormat() -> String { formatted(.dateTime.month().year()) }
}

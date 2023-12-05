//
//  String+Ext.swift
//  GitHubFollowers
//
//  Created by Māris Lakšs on 05/12/2023.
//

import Foundation

extension String {
    // This function will convert the date to a string
    func convertToDate() -> Date? {
        // Create a date formatter
        let dateFormatter = DateFormatter()
        // Set the date format
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        // Set the date formatter's locale
        dateFormatter.locale = Locale(identifier: "lv_LV") // en_US_POSIX
        // Set the date formatter's timezone
        dateFormatter.timeZone = .current

        // Return the date
        return dateFormatter.date(from: self)
    }

    // This function will convert the date to a string,
    // it basically combines both Date & String extensions
    func convertToDisplayFormat() -> String {
        // Convert the string to a date
        guard let date = convertToDate() else { return "N/A" }
        // Return the date in a specific format
        return date.convertToMonthYearFormat()
    }
}

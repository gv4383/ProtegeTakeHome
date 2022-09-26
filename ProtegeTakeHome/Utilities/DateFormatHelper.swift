//
//  DateFormatHelper.swift
//  ProtegeTakeHome
//
//  Created by Goyo Vargas on 9/26/22.
//

import Foundation

struct DateFormatHelper {
    static func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EE, MMM d, h:mm a"
        
        return formatter.string(from: date)
    }
}

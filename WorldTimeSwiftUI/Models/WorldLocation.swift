//
//  WorldLocation.swift
//  WorldTimeSwiftUI
//
//  Created by Christopher Elbert on 8/16/22.
//

import Foundation

struct WorldLocation: Identifiable {
    var id = UUID()
    var locationName: String
    var locationId: String
    var flagImageId: String?
    var dateTime: Date? = nil
    
    var formattedTime: String? {
        get {
            guard let dateTime = dateTime else {
                return nil
            }

            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "en_US_POSIX")
            formatter.timeZone = TimeZone(identifier: locationId)
            formatter.dateFormat = "h:mm a"
            formatter.amSymbol = "AM"
            formatter.pmSymbol = "PM"
            
            return formatter.string(from: dateTime)
        }
    }
    
    var isDayTime: Bool {
        get {
            guard let hour = formattedTime?.first?.wholeNumberValue, let amPm = formattedTime?.suffix(2) else {
                return true
            }
            
            return amPm == "AM" ? hour >= 4 : hour < 6
        }
    }
    
    static func getDefualtWorldLocation() -> WorldLocation {
        let timezoneId = TimeZone.current.identifier
        let location = timezoneId.components(separatedBy: "/").last?.replacingOccurrences(of: "_", with: " ") ?? "Unknown Location"
        let currentDate = Date()
        
        return WorldLocation(locationName: location, locationId: timezoneId, flagImageId: nil, dateTime: currentDate)
    }
}

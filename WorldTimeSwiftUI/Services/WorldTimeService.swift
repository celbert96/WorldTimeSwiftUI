//
//  WorldTimeService.swift
//  WorldTimeSwiftUI
//
//  Created by Christopher Elbert on 8/17/22.
//

import SwiftUI

class WorldTimeService: ObservableObject {
    @Published var currentLocation = WorldLocation.getDefualtWorldLocation()
    
    let BASE_URL_STRING = "https://worldtimeapi.org/api/timezone/"
    
    enum FetchError: Error {
        case badRequest
        case badJSON
    }
    
    func fetchData() async throws {
        let urlString = BASE_URL_STRING + currentLocation.locationId
        guard let url = URL(string: urlString) else {
            print("Could not initialize url")
            return
        }
                
        let (data, response) = try await URLSession.shared.data(for: URLRequest(url: url))
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            print("Bad Request")
            throw FetchError.badRequest
        }
        
        
        if let json = try JSONSerialization.jsonObject(with: data) as? [String:Any] {
            guard let datetime = json["datetime"] as? String else {
                return
            }
            
            Task { @MainActor in
                let dateFormatter = DateFormatter()
                dateFormatter.locale = Locale(identifier: "en_US_POSIX")
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
                currentLocation.dateTime = dateFormatter.date(from: datetime)
            }
        }
    }
}

//
//  SelectLocationView.swift
//  WorldTimeSwiftUI
//
//  Created by Christopher Elbert on 8/15/22.
//

import SwiftUI

struct SelectLocationView: View {
    @EnvironmentObject var worldTimeService: WorldTimeService
    @Environment(\.dismiss) var dismiss
    
    private let locations: [WorldLocation] = [
        WorldLocation(locationName: "Athens", locationId: "Europe/Athens", flagImageId: "Greece"),
        WorldLocation(locationName: "Berlin", locationId: "Europe/Berlin", flagImageId: "Germany"),
        WorldLocation(locationName: "Cairo", locationId: "Africa/Cairo", flagImageId: "Egypt"),
        WorldLocation(locationName: "New York", locationId: "America/New_York", flagImageId: "USA"),
    ]
    
    var body: some View {
        List {
            ForEach(locations) { location in
                Button {
                    print("List item pressed")
                    Task {
                        worldTimeService.currentLocation = location
                        do {
                            try await worldTimeService.fetchData()
                            dismiss()
                        } catch(let error) {
                            print("An error occurred: \(error.localizedDescription)")
                            dismiss()
                        }
                        
                    }
                    
                    
                } label: {
                    HStack {
                        Image(location.flagImageId!)
                            .resizable()
                            .frame(width: 30, height: 30, alignment: .center)
                        Text(location.locationName)
                    }
                }.padding()
            }
            
        }
        .navigationTitle(Text("Choose Location"))
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct SelectLocationView_Previews: PreviewProvider {
    static var previews: some View {
        SelectLocationView().environmentObject(WorldTimeService())
    }
}

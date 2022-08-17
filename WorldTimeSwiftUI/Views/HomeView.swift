//
//  HomeVIew.swift
//  WorldTimeSwiftUI
//
//  Created by Christopher Elbert on 8/15/22.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var worldTimeService: WorldTimeService
    
    @State private var isNightMode = true
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: SelectLocationView()) {
                    HStack {
                        Image(systemName: "location.fill")
                            .padding(.trailing, 4)
                        
                        Text("Edit Location")
                    }
                }
                .padding(.top, 100)
                .foregroundColor(.white)
                
                
                
                Spacer().frame(minHeight: 20, idealHeight: 20, maxHeight: 20)
                
                Text(worldTimeService.currentLocation.locationName)
                    .tracking(2)
                    .padding()
                    .font(.system(size: 28, weight: .regular, design: .default))
                    .foregroundColor(.white)
                
                
                Spacer().frame(minHeight: 20, idealHeight: 20, maxHeight: 20)
                
                Text(worldTimeService.currentLocation.formattedTime ?? "ERR_FAILED_TO_GET_TIME")
                    .font(.system(size: 66, weight: .regular, design: .default))
                    .tracking(2)
                    .foregroundColor(.white)
                
                Spacer()
            }
            .background(
                Image(worldTimeService.currentLocation.isDayTime ? "DayBackground" : "NightBackground")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            )
        }
        .statusBar(hidden: true)
    }
}

struct HomeVIew_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environmentObject(WorldTimeService())
    }
}

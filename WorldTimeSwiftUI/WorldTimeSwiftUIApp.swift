//
//  WorldTimeSwiftUIApp.swift
//  WorldTimeSwiftUI
//
//  Created by Christopher Elbert on 8/15/22.
//

import SwiftUI

@main
struct WorldTimeSwiftUIApp: App {
    @StateObject private var worldTimeService = WorldTimeService()
    var body: some Scene {
        WindowGroup {
            HomeView().environmentObject(worldTimeService)
        }
    }
}

//
//  SpaceXInfoApp.swift
//  SpaceXInfo
//
//  Created by Alexander Grigorov on 19.05.2022.
//

import SwiftUI

@main
struct SpaceXInfoApp: App {
    @State var appStorage = SpaceStorage()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appStorage)
        }
    }
}

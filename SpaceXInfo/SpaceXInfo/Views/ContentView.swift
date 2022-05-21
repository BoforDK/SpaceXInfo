//
//  ContentView.swift
//  SpaceXInfo
//
//  Created by Alexander Grigorov on 19.05.2022.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var appStorage: AppStorage
    @State private var searchText = ""
    
    let columns = [
        GridItem(),
        GridItem(),
        GridItem(),
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(appStorage.launches.filter { searchText.isEmpty ? true : $0.name.contains(searchText)}) { launch in
                        NavigationLink( destination: {
                            LaunchDetails(launch: launch)
                        }) {
                            LauncheItem(item: launch)
                        }
                    }
                }
            }
            .searchable(text: $searchText)
            .navigationTitle("Space X Launches")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

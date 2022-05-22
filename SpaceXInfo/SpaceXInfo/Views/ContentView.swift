//
//  ContentView.swift
//  SpaceXInfo
//
//  Created by Alexander Grigorov on 19.05.2022.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var appStorage: AppStorage
    @State private var showingOptions = false
    @State private var searchText = ""
    @State private var sortRevert: Bool = UserDefaults.standard.bool(forKey: "sortRevert") {
        didSet {
            UserDefaults.standard.set(sortRevert, forKey: "sortRevert")
        }
    }
    
    @State private var sortBy = Launch.SortedKeys.init(rawValue: UserDefaults.standard.string(forKey: "SortedKeys")) {
        didSet {
            UserDefaults.standard.set(sortBy.rawValue, forKey: "SortedKeys")
        }
    }
    
    let columns = [
        GridItem(),
        GridItem(),
        GridItem(),
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns) {
                    launchItems
                }
            }
            .searchable(text: $searchText)
            .navigationTitle("Space X Launches")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    sortButton
                        .confirmationDialog("Sort by", isPresented: $showingOptions, titleVisibility: .visible) {
                            sortConfirmationDialog
                        }
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    var launchItems: some View {
        ForEach(appStorage.launches
            .filter { searchText.isEmpty ? true : $0.name.contains(searchText)}
            .sorted { sortRevert != sortBy.getFilter($0, $1) }
        ) { launch in
            NavigationLink( destination: {
                LaunchDetails(launch: launch)
            }) {
                LauncheItem(item: launch)
            }
        }
    }
    
    var sortButton: some View {
        Button(action: {
            showingOptions.toggle()
        }, label: {
            Image(systemName: "arrow.up.arrow.down")
        })
    }
    
    var sortConfirmationDialog: some View {
        ForEach(Launch.SortedKeys.allCases, id: \.self) { sortBy in
            Button(sortBy.rawValue) {
                if self.sortBy == sortBy {
                    sortRevert.toggle()
                } else {
                    self.sortBy = sortBy
                    sortRevert = false
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

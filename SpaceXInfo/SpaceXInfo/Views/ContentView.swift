//
//  ContentView.swift
//  SpaceXInfo
//
//  Created by Alexander Grigorov on 19.05.2022.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var appStorage: AppStorage
    @State private var isShowingFlightNumberAllert = false
    @State private var isShowingSortOptions = false
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
    
    @State private var isShowingFlightNumber = UserDefaults.standard.bool(forKey: "isShowingFlightNumber") {
        didSet {
            UserDefaults.standard.set(isShowingFlightNumber, forKey: "isShowingFlightNumber")
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
                        .confirmationDialog("Sort by", isPresented: $isShowingSortOptions, titleVisibility: .visible) {
                            sortConfirmationDialog
                        }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    showFlightNumberButton
                }
            }
        }
        .alert("Flight number was \(isShowingFlightNumber ? "shown" : "hidden")",
               isPresented: $isShowingFlightNumberAllert,
               actions: {})
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    var launchItems: some View {
        ForEach(appStorage.launches
            .filter { searchText.isEmpty ? true : $0.name.lowercased().contains(searchText.lowercased())}
            .sorted { sortRevert != sortBy.getFilter($0, $1) }
        ) { launch in
            NavigationLink( destination: {
                LaunchDetails(launch: launch)
            }) {
                LauncheItem(item: launch, showFlightNumber: isShowingFlightNumber)
            }
        }
    }
    
    var sortButton: some View {
        Button(action: {
            isShowingSortOptions.toggle()
        }, label: {
            Image(systemName: "arrow.up.arrow.down.circle")
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
    
    var showFlightNumberButton: some View {
        Button(action: {
            isShowingFlightNumberAllert.toggle()
            isShowingFlightNumber.toggle()
        }, label: {
            Image(systemName: "1.circle")
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

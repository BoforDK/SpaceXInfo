//
//  ContentView.swift
//  SpaceXInfo
//
//  Created by Alexander Grigorov on 19.05.2022.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        switch appState.state {
        case .done(let launches):
            LaunchesView(launches: launches)
        case .loading:
            ProgressView()
        case .error(let error):
            ErrorView(error: error)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

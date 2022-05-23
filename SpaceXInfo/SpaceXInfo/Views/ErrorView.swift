//
//  ErrorView.swift
//  SpaceXInfo
//
//  Created by Alexander Grigorov on 23.05.2022.
//

import SwiftUI
import Alamofire

struct ErrorView: View {
    @EnvironmentObject var appState: AppState
    @State var showAlert = false
    var error: AFError
    
    var body: some View {
        switch error {
        case .sessionTaskFailed(error: _):
            Text("Network session failed")
                .font(.title)
                .foregroundColor(.red)
                .alert("Does the reload launches?",
                       isPresented: $showAlert,
                       actions: {
                    Button("Reload") {
                        appState.reloadData()
                    }
                    Button("Cancel", role: .cancel) {
                    }
                })
                .onAppear {
                    showAlert = true
                }
        default:
            Text("Something went wrong:(")
                .font(.title)
                .foregroundColor(.red)
        }
    }
}

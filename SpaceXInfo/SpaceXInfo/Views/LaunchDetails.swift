//
//  LaunchDetails.swift
//  SpaceXInfo
//
//  Created by Alexander Grigorov on 21.05.2022.
//

import SwiftUI

struct LaunchDetails: View {
    var launch: Launch
    var imageSize: CGFloat = 80
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                AsyncImage(url: URL(string: launch.links.patch.large ?? "")) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    Color.purple.opacity(0.1)
                }
                
                Section("Details:") {
                    Text(launch.details ?? "No details")
                }
                
                Section("Links:") {
                    Text(launch.links.reddit.media ?? "No reddit")
                }
            }
        }
        .navigationTitle(launch.name)
    }
}

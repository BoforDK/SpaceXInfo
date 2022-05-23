//
//  LaunchDetailsView.swift
//  SpaceXInfo
//
//  Created by Alexander Grigorov on 21.05.2022.
//

import SwiftUI

struct LaunchDetailsView: View {
    var launch: Launch
    var imageSize: CGFloat = 80
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                HStack {
                    Spacer()
                    ImageWithPlaceholderView(stringURL: launch.links.patch.large)
                    Spacer()
                }
                
                Text("Details:")
                    .font(.title)
                    .padding(.top)
                Text(launch.details ?? "No details")
                
                Text("Links:")
                    .font(.title)
                    .padding(.top)
                
                LinkView(stringLink: launch.links.reddit.media, text: "Reddit")
                LinkView(stringLink: launch.links.article, text: "Article")
                LinkView(stringLink: launch.links.wikipedia, text: "Wikipedia")
            }
        }
        .navigationTitle(launch.name)
    }
}

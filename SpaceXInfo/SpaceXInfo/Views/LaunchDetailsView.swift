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
                AsyncImage(url: URL(string: launch.links.patch.large ?? "")) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    Color.purple.opacity(0.1)
                }
                
                Text("Details:")
                    .font(.title)
                    .padding(.top)
                Text(launch.details ?? "No details")
                
                Text("Links:")
                    .font(.title)
                    .padding(.top)
                HStack {
                    LinkView(stringLink: launch.links.reddit.media, text: "Reddit")
                }
                LinkView(stringLink: launch.links.article, text: "Article")
                LinkView(stringLink: launch.links.wikipedia, text: "Wikipedia")
            }
        }
        .navigationTitle(launch.name)
    }
}

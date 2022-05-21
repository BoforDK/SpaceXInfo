//
//  LauncheItem.swift
//  SpaceXInfo
//
//  Created by Alexander Grigorov on 21.05.2022.
//

import SwiftUI

struct LauncheItem: View {
    var item: Launch
    var imageSize: CGFloat = 80
    var imageBottomPadding: CGFloat = 2
    var itemPadding: CGFloat = 2
    var detailsLineLimit = 1
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: item.links.patch.small ?? "")) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: imageSize, height: imageSize)
            } placeholder: {
                Color.purple.opacity(0.1)
            }
            .frame(width: imageSize, height: imageSize)
            .padding(.bottom, imageBottomPadding)
            
            Text(item.name)
                .font(.title3)
                .bold()
                .foregroundColor(.black)
                .lineLimit(detailsLineLimit)
        }
        .frame(width: 100 + 10, height: 100 + 40)
        .background(
            Rectangle()
                .foregroundColor(.gray.opacity(0.2))
                .cornerRadius(10)
        )
    }
}

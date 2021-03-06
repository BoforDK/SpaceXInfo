//
//  LaunchItemView.swift
//  SpaceXInfo
//
//  Created by Alexander Grigorov on 21.05.2022.
//

import SwiftUI

struct LaunchItemView: View {
    @Environment(\.colorScheme) var colorScheme
    
    var item: Launch
    var showFlightNumber = false
    var imageSize: CGFloat = 80
    var imageBottomPadding: CGFloat = 2
    var itemPadding: CGFloat = 2
    var detailsLineLimit = 1
    var itemWidth: CGFloat = 110
    var itemHeight: CGFloat = 140
    var itemHeightWithFlightNumber: CGFloat = 150
    var itemCornerRadius: CGFloat = 10
    var itemColor = Color.gray.opacity(0.2)
    
    var body: some View {
        VStack {
            ImageWithPlaceholderView(stringURL: item.links.patch.small)
                .frame(width: imageSize, height: imageSize)
                .padding(.bottom, imageBottomPadding)
            
            Text(item.name)
                .font(.title3)
                .bold()
                .foregroundColor(colorScheme == .light ? .black : .white)
                .lineLimit(detailsLineLimit)
            
            if showFlightNumber {
                Text(("\(item.flightNumber)"))
                    .foregroundColor(colorScheme == .light ? .black : .white)
            }
        }
        .frame(width: itemWidth,
               height: showFlightNumber ? itemHeightWithFlightNumber : itemHeight)
        .background(
            Rectangle()
                .foregroundColor(itemColor)
                .cornerRadius(itemCornerRadius)
        )
    }
}

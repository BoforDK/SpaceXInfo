//
//  ImageWithPlaceholderView.swift
//  SpaceXInfo
//
//  Created by Alexander Grigorov on 23.05.2022.
//

import SwiftUI

struct ImageWithPlaceholderView: View {
    var stringURL: String?
    
    var body: some View {
        if let itemImage = stringURL {
            AsyncImage(url: URL(string: itemImage)) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                ProgressView()
            }
        } else {
            Image("SpaceX")
                .resizable()
                .aspectRatio(contentMode: .fit)
        }
    }
}

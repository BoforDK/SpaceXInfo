//
//  LinkView.swift
//  SpaceXInfo
//
//  Created by Alexander Grigorov on 23.05.2022.
//

import SwiftUI

struct LinkView: View {
    var stringLink: String?
    var text: String
    
    var body: some View {
        if let url = URL(string: stringLink ?? "") {
            Link(text, destination: url)
        } else {
            Text("No link (\(text))")
        }
    }
}

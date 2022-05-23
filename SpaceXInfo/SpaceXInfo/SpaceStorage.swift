//
//  SpaceStorage.swift
//  SpaceXInfo
//
//  Created by Alexander Grigorov on 21.05.2022.
//

import Foundation
import Combine
import Alamofire

class SpaceStorage: ObservableObject {
    @Published var launches: [Launch] = []
    private let decoder = JSONDecoder()
    private var cancellables = Set<AnyCancellable>()
    private(set) var state = State.initialization
    
    enum State {
        case initialization
        case loading
        case idle
        case error(String)
    }
    
    init() {
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        AF.request("https://api.spacexdata.com/v4/launches", method: .get)
            .validate()
            .publishDecodable(type: [Launch].self, decoder: decoder)
            .sink { data in
                if (data.error != nil) {
                    self.state = .error("Error: \(data)....... \(data.error!)")
                    print("Error: \(data)....... \(data.error!)")
                } else {
                    self.launches = data.value ?? []
                    print("OK \(data.value!.count)")
                }

            }
            .store(in: &cancellables)
    }
}

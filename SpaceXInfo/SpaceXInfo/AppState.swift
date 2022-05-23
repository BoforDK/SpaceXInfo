//
//  AppState.swift
//  SpaceXInfo
//
//  Created by Alexander Grigorov on 21.05.2022.
//

import Foundation
import Combine
import Alamofire

class AppState: ObservableObject {
    private let decoder = JSONDecoder()
    private var cancellables: AnyCancellable!
    @Published private(set) var state: State
    
    enum State {
        case loading
        case error(AFError)
        case done([Launch])
    }
    
    init() {
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        self.state = .loading
        
        loadData()
    }
    
    private func loadData() {
        cancellables = AF.request(LaunchRESTAPI.launches, method: .get)
            .validate()
            .publishDecodable(type: [Launch].self, decoder: decoder)
            .sink(receiveValue: recieveDate)
    }
    
    func reloadData() {
        self.state = .loading
        
        loadData()
    }
    
    private func recieveDate(data: DataResponse<[Launch], AFError>) {
        if let error = data.error {
            self.state = .error(error)
        } else {
            self.state = .done(data.value ?? [])
        }
    }
}

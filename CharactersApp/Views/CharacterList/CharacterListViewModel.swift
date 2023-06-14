//
//  CharacterListViewModel.swift
//  CharacterViewerApp
//
//  Created by Paul on 6/12/23.
//

import Foundation
import Combine

class CharacterListViewModel {
    
    var characterDataPublisher: AnyPublisher<[CharacterModel], Never> {
        characterDataSubject.eraseToAnyPublisher()
    }
    private let characterDataSubject = CurrentValueSubject<[CharacterModel], Never>([])
    private var cancellables = Set<AnyCancellable>()
    
    init() { }
    
    
    func fetchData() {
        let request = Environment.Characters.request
        let network: NetworkManagerType = NetworkManager()
        network.getModel(request: request)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                print(completion)
            }, receiveValue: { [weak self] (model: CharacterModelContainer) in
                self?.characterDataSubject.send(model.RelatedTopics)
            })
            .store(in: &cancellables)
    }
}

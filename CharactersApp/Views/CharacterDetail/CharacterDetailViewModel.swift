//
//  CharacterDetailViewModel.swift
//  CharacterViewerApp
//
//  Created by Paul on 6/12/23.
//

import Foundation
import Combine

class CharacterDetailViewModel {
    @Published var characterImage: URL? = nil
    @Published var characterDescription: String? = nil

    init() {}

    func update(characterImage: String, characterDescription: String) {
        self.characterDescription = characterDescription
        if let imageURLString = getImageLink() {
            self.characterImage = URL(string: imageURLString)
        }
    }

    private func getImageLink() -> String? {
        return "\(Environment.Domain)\(characterImage)"
    }
}

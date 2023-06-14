//
//  CharacterDetailViewController.swift
//  CharacterViewerApp
//
//  Created by Paul on 6/12/23.
//

import UIKit
import Foundation
import Kingfisher
import Combine

class CharacterDetailViewController: UIViewController {
    
    @IBOutlet weak var characterIcon: UIImageView!
    @IBOutlet weak var characterText: UILabel!
    
    public var character: CharacterModel?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupView()
    }

    private func setupView() {
        guard let character = self.character else {
            return
        }

        self.characterText?.text = character.Text
        self.characterIcon?.kf.setImage(with: URL(string: "\(Environment.ImageBase)\(character.Icon.URL)"), placeholder: UIImage(named: "placeholder"))
    }
}

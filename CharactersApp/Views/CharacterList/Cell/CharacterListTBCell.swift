//
//  CharacterListTBCell.swift
//  CharacterViewerApp
//
//  Created by Paul on 6/12/23.
//

import Foundation
import UIKit

class CharacterListTBCell: UITableViewCell {
    
    static let identifier = "CharacterListTBCell"
    
    @IBOutlet weak var title: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

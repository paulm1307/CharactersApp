//
//  ViewController.swift
//  CharacterViewerApp
//
//  Created by Paul on 6/13/23.
//

import UIKit
import Combine

class CharacterListViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableview: UITableView!
    
    private var viewModel = CharacterListViewModel()
    private var characterList: [CharacterModel] = []
    private var originalList: [CharacterModel] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        
        self.viewModel.fetchData()
        self.configureTableView()
        self.configureBinding()
    }
    
    func configureTableView() {
        
        self.tableview.delegate = self
        self.tableview.dataSource = self
        tableview.register(UINib(nibName: "CharacterListTBCell", bundle: nil), forCellReuseIdentifier: "CharacterListTBCell")
        self.tableview.rowHeight = UITableView.automaticDimension
        self.tableview.estimatedRowHeight = 50.0
        
        tableview.tableHeaderView = searchBar
        
        self.tableview.reloadData()
    }
    
    func configureBinding() {
        viewModel.characterDataPublisher
            .sink { [weak self] characters in
                print(characters)
                self?.characterList = characters
                self?.originalList = characters
                self?.tableview.reloadData()
            }
            .store(in: &cancellables)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetailSegue",
           let destinationVC = segue.destination as? CharacterDetailViewController,
           let selectedCharacter = sender as? CharacterModel {
            destinationVC.character = selectedCharacter
        }
    }

}

extension CharacterListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        characterList = self.characterList.filter { $0.Text.lowercased().contains(searchText.lowercased()) }
        
        tableview.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        characterList = originalList
        searchBar.resignFirstResponder()
        tableview.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

extension CharacterListViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.characterList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CharacterListTBCell.identifier) as! CharacterListTBCell
        
        let character = self.characterList[indexPath.row]
        
        cell.title.text = character.Text
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCharacter = self.characterList[indexPath.row]
            
            let detailViewController = CharacterDetailViewController(nibName: "CharacterDetailViewController", bundle: nil)
            detailViewController.character = selectedCharacter
            
            self.present(detailViewController, animated: true, completion: nil)
    }
}


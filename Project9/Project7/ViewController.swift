//
//  ViewController.swift
//  Project7
//
//  Created by JEONGSEOB HONG on 2021/07/11.
//

import UIKit

class ViewController: UITableViewController {
    
    enum Constants {
        static let alertCreditsTitle = "Credits"
        static let alertCreditsMessage = "the data comes from the We People API of the WhiteHouse"
        static let alertCreditsDismiss = "Dismiss"
        static let alertFilterTitle = "Filter"
        static let alertFilterMessage = "Search petition"
        static let alertFilterSearch = "Search"
        static let alertFilterDismiss = "Dismiss"
    }
    
    var petitions = [Petition]()
    var filteredPetitions = [Petition]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Credits by Code",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(showCreditsAlert))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Filter by Code",
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(showFilterAlert))
        
        performSelector(inBackground: #selector(fetchJSON), with: self)
        
    }
    
    @objc func fetchJSON() {
        let urlString: String
        
        if navigationController?.tabBarItem.tag == 0 {
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        } else {
            urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
        }
        
        
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                parse(json: data)
                return
            }
        }
        
        performSelector(onMainThread: #selector(showError), with: self, waitUntilDone: false)
    }
    
    @objc func showError() {
        DispatchQueue.main.async { [weak self] in
            let ac = UIAlertController(title: "Loading error",
                                       message: "There was a problem loading the feed;  please check your connection and try again.",
                                       preferredStyle: .alert)
            
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            
            self?.present(ac, animated: true)
        }
        
    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()
        
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            petitions = jsonPetitions.results
            filteredPetitions = petitions
            
            tableView.performSelector(onMainThread: #selector(UITableView.reloadData),
                                      with: self,
                                      waitUntilDone: false)
            
        } else {
            performSelector(onMainThread: #selector(showError),
                            with: self,
                            waitUntilDone: false)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredPetitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let petition = filteredPetitions[indexPath.row]
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let detailViewController = DetailViewController()
        detailViewController.detailItem = petitions[indexPath.row]
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    
    @objc func showCreditsAlert() {
        let alertController = UIAlertController(title: Constants.alertCreditsTitle,
                                                message: Constants.alertCreditsMessage,
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: Constants.alertCreditsDismiss, style: .cancel, handler: nil))
        present(alertController, animated: true)
    }
    
    @objc func showFilterAlert() {
        let alertController = UIAlertController(title: Constants.alertFilterTitle,
                                                message: Constants.alertFilterMessage,
                                                preferredStyle: .alert)
        alertController.addTextField()
        alertController.addAction(UIAlertAction(title: Constants.alertFilterSearch, style: .default, handler: { [weak self] _ in
            guard let text = alertController.textFields?[0].text else { return }
            guard let strongSelf = self else { return }
            strongSelf.filteredPetitions = strongSelf.petitions.filter { petition in
                let lowercasedText = text.lowercased()
                return petition.title.lowercased().contains(lowercasedText)
            }
            strongSelf.tableView.reloadData()
            
        }))
        alertController.addAction(UIAlertAction(title: Constants.alertFilterDismiss, style: .cancel, handler: nil))
        present(alertController, animated: true)
        
    }
    
}


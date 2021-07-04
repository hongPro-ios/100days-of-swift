//
//  SiteTableViewController.swift
//  Project4
//
//  Created by JEONGSEOB HONG on 2021/07/04.
//

import UIKit


enum Site: Int, CaseIterable {
    case apple
    case hackingwithswift
    
    var url: String {
        switch self {
        case .apple:
            return "apple.com"
        case .hackingwithswift:
            return "hackingwithswift.com"
        }
    }
    
    var siteName: String {
        switch self {
        case .apple:
            return "Apple"
        case .hackingwithswift:
            return "Hackingwithswift"
        }
    }
}

class SiteTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Site.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = Site(rawValue: indexPath.row)?.siteName
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let initSite =  Site(rawValue: indexPath.row) else { return }
        
        let webViewController = WebViewController(initSite: initSite)
        navigationController?.pushViewController(webViewController, animated: true)
    }
}

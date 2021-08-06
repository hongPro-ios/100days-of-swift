//
//  ViewController.swift
//  Projects Consolidation 13-15
//
//  Created by JEONGSEOB HONG on 2021/08/06.
//

import UIKit

class CountryTableViewController: UITableViewController {
    var countryList = [Country]()
    override func loadView() {
        super.loadView()
        
        guard let countriesInfoURL = Bundle.main.url(forResource: "CountriesInfo", withExtension: "json") else { return }
        
        do {
            let countriesInfoData = try Data(contentsOf: countriesInfoURL)
            let jsonDecoder = JSONDecoder()
            countryList = try jsonDecoder.decode([Country].self, from: countriesInfoData)
        } catch {
            print("jsonDecoder error")
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Countries"
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        countryList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "country", for: indexPath)
        cell.textLabel?.text = countryList[indexPath.row].name

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let country = countryList[indexPath.row]
        let countryDetailViewController = CountryDetailViewController(country: country)
        navigationController?.pushViewController(countryDetailViewController, animated: true)

    }

}


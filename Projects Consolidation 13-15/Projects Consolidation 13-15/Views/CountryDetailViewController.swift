//
//  CountryDetailViewController.swift
//  Projects Consolidation 13-15
//
//  Created by JEONGSEOB HONG on 2021/08/06.
//

import UIKit

class CountryDetailViewController: UIViewController {
    let country: Country
    
    var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textColor = .white
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        return nameLabel
    }()
    var capitalCityLabel: UILabel = {
        let capitalCityLabel = UILabel()
        capitalCityLabel.textColor = .white
        capitalCityLabel.translatesAutoresizingMaskIntoConstraints = false
        return capitalCityLabel
    }()
    var sizeLabel: UILabel = {
        let sizeLabel = UILabel()
        sizeLabel.textColor = .white
        sizeLabel.translatesAutoresizingMaskIntoConstraints = false
        return sizeLabel
    }()
    var populationLabel: UILabel = {
        let populationLabel = UILabel()
        populationLabel.textColor = .white
        populationLabel.translatesAutoresizingMaskIntoConstraints = false
        return populationLabel
    }()
    var currencyLabel: UILabel = {
        let currency = UILabel()
        currency.textColor = .white
        currency.translatesAutoresizingMaskIntoConstraints = false
        return currency
    }()
    
    init(country: Country) {
        self.country = country
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = country.name
        
        view.backgroundColor = .black
        
        nameLabel.text = "name: " + country.name
        view.addSubview(nameLabel)
        
        capitalCityLabel.text = "capitalCity: " + country.capital
        view.addSubview(capitalCityLabel)
        
        sizeLabel.text = "size: " + String(country.area ?? 0)
        view.addSubview(sizeLabel)
        
        populationLabel.text = "population: " + String(country.population)
        view.addSubview(populationLabel)
        
        currencyLabel.text = "currency: " + ((country.currencies[0]).name ?? "No")
        view.addSubview(currencyLabel)
        
        let verticalStackView = UIStackView(arrangedSubviews: [nameLabel, capitalCityLabel, sizeLabel, populationLabel, currencyLabel])
        verticalStackView.axis = .vertical
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(verticalStackView)
        
        NSLayoutConstraint.activate([
            verticalStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 100),
            verticalStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 200)
        ])
    }
    
}


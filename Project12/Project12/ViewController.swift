//
//  ViewController.swift
//  Project12
//
//  Created by JEONGSEOB HONG on 2021/07/26.
//

import UIKit

class ViewController: UIViewController {
    var people = [Person]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = UserDefaults.standard
        
        defaults.set(25, forKey: "Age")
        defaults.set(true, forKey: "UserFaceID")
        defaults.set(CGFloat.pi, forKey: "Pi")
        defaults.set("hong", forKey: "Name")
        defaults.set(Data(), forKey: "LastRun")
        let array = ["hey", "baby"]
        defaults.set(array, forKey: "SavedArray")
        let dict = ["Name": "Hong", "Country": "Korea"]
        defaults.set(dict, forKey: "SavedDictionary")
        
        _ = defaults.integer(forKey: "Age")
        _ = defaults.bool(forKey: "UserFaceID")
        
        _ = defaults.object(forKey: "SavedArray") as? [String] ?? [String]()
        _ = defaults.object(forKey: "SavedDictionary") as? [String: String] ?? [String: String]()
        
        
        
    }
    
    func save() {
        if let savedData = try? NSKeyedArchiver.archivedData(withRootObject: people, requiringSecureCoding: false) {
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: "people")
        }
    }
    
    
}



class Person: NSCoding {
    var name: String
    
    
    required init?(coder: NSCoder) {
        name = coder.decodeObject(forKey: "name") as? String ?? ""
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(name, forKey: "name")
    }
    
    
    
    
    
    
}

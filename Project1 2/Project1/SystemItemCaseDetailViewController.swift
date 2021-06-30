//
//  SystemItemCaseDetailViewController.swift
//  Project1
//
//  Created by JEONGSEOB HONG on 2021/06/30.
//

import UIKit

class SystemItemCaseDetailViewController: UIViewController {
    var index = 0

    init(index: Int) {
        self.index = index
        super.init(nibName: nil, bundle: nil)
        title = "SystemItem: \(UIBarButtonItem.SystemItem.init(rawValue: index)?.description ?? "")"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .init(rawValue: index)!, target: nil, action: nil)
    }
}

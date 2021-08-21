//
//  NoteDetailViewController.swift
//  Projects Consolidation 19-21
//
//  Created by JEONGSEOB HONG on 2021/08/21.
//

import UIKit

class NoteDetailViewController: UIViewController {
    
    @IBOutlet var contextTextView: UITextView!
    var note: Note?

    override func viewDidLoad() {
        super.viewDidLoad()
        contextTextView.text = note?.context
    }
    
    func configure(note: Note) {
        self.note = note
    }
   
}

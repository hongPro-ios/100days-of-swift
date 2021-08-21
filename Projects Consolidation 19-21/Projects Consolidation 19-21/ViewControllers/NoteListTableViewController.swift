//
//  NoteListTableViewController.swift
//  Projects Consolidation 19-21
//
//  Created by JEONGSEOB HONG on 2021/08/21.
//

import UIKit

class NoteListTableViewController: UITableViewController {
    
    var notes = [Note]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Note"
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func configure(notes: [Note], folderTitle: String) {
        title = folderTitle
        self.notes = notes
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        notes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell", for: indexPath)
        let note = notes[indexPath.row]
        cell.textLabel?.text = note.title
        cell.detailTextLabel?.text = note.context
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let noteDetailViewController = storyboard?.instantiateViewController(identifier: "NoteDetailViewController") as? NoteDetailViewController else { return }
        let note = notes[indexPath.row]
        noteDetailViewController.configure(note: note)
        navigationController?.pushViewController(noteDetailViewController, animated: true)
    }
    
}


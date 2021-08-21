//
//  FolderListTableViewController.swift
//  Projects Consolidation 19-21
//
//  Created by JEONGSEOB HONG on 2021/08/21.
//

import UIKit

class FolderListTableViewController: UITableViewController {
    var folders = [Folder]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        loadNoteData()
    }
    
    func loadNoteData() {
        folders = loadJsonFile(name: "notesData")!
    }
    
    func loadJsonFile(name: String) -> [Folder]? {
        guard let url = Bundle.main.url(forResource: name, withExtension: "json") else { fatalError() }
        do {
            let notesData = try Data(contentsOf: url)
            let jsonDecoder = JSONDecoder()
            return try jsonDecoder.decode([Folder].self, from: notesData)
        } catch {
            fatalError()
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        folders.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "folderCell", for: indexPath)
        cell.textLabel?.text = folders[indexPath.row].title
        return cell
    }
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let noteListTableViewController = storyboard?.instantiateViewController(identifier: "NoteListTableViewController") as? NoteListTableViewController else { return }
        let folder = folders[indexPath.row]
        noteListTableViewController.configure(notes: folder.notes , folderTitle: folder.title)
        navigationController?.pushViewController(noteListTableViewController, animated: true)
        
    }
    
}

//
//  SystemItemCaseViewController.swift
//  Project1
//
//  Created by JEONGSEOB HONG on 2021/06/30.
//

import UIKit

class SystemItemCaseViewController: UITableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        UIBarButtonItem.SystemItem.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = UIBarButtonItem.SystemItem.init(rawValue: indexPath.row)?.description
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = SystemItemCaseDetailViewController(index: indexPath.row)
        //            viewController.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .init(rawValue: indexPath.row)!, target: nil, action: nil)
        navigationController?.pushViewController(viewController, animated: true)
        
    }
}

extension UIBarButtonItem.SystemItem: CaseIterable, CustomStringConvertible {
    
    
    public static var allCases: [UIBarButtonItem.SystemItem] {
        [.done, .cancel, .edit, save, add, .flexibleSpace, .fixedSpace, compose, reply, action, organize, bookmarks, search, refresh, stop, camera, trash, play, pause, rewind, fastForward, undo, redo, pageCurl, close]
    }
    
    public var description: String {
        switch self {
        case .action:
            return "action"
        case .done:
            return "done"
        case .cancel:
            return "cancel"
        case .edit:
            return "edit"
        case .save:
            return "save"
        case .add:
            return "add"
        case .flexibleSpace:
            return "flexibleSpace"
        case .fixedSpace:
            return "fixedSpace"
        case .compose:
            return "compose"
        case .reply:
            return "reply"
        case .organize:
            return "organize"
        case .bookmarks:
            return "bookmarks"
        case .search:
            return "search"
        case .refresh:
            return "refresh"
        case .stop:
            return "stop"
        case .camera:
            return "camera"
        case .trash:
            return "trash"
        case .play:
            return "play"
        case .pause:
            return "pause"
        case .rewind:
            return "rewind"
        case .fastForward:
            return "fastForward"
        case .undo:
            return "undo"
        case .redo:
            return "redo"
        case .pageCurl:
            return "pageCurl"
        case .close:
            return "close"
            
        @unknown default:
            fatalError()
        }
    }
    
}

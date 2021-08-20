//
//  AlertBuilder.swift
//  Project21
//
//  Created by JEONGSEOB HONG on 2021/08/20.
//

import UIKit

class AlertBuilder {
    static func simpleAlert(
        title: String?,
        message: String? = nil,
        confirm: String = "Confirm",
        negative: String? = nil,
        completion: @escaping ()->() = {})
    -> UIAlertController
    {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let gotit = UIAlertAction(title: confirm, style: .default) { _ in completion() }
        alertController.addAction(gotit)
        if let negative = negative {
            let negativeAction = UIAlertAction(title: negative, style: .default)
            alertController.addAction(negativeAction)
        }
        return alertController
    }
    
    static func errorAlert(message: String) -> UIAlertController {
        let alertController = UIAlertController(
            title: "Error",
            message: message,
            preferredStyle: .alert)
        let confirm = UIAlertAction(title: "Confirm", style: .default)
        alertController.addAction(confirm)
        return alertController
    }
    
    static func errorAlert(
        message: String,
        confirmText: String,
        cancelText: String,
        confirmAction: ((UIAlertAction) -> Void)? = nil)
    -> UIAlertController
    {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let okay = UIAlertAction(title: confirmText, style: .default, handler: confirmAction)
        alertController.addAction(okay)
        let cancel = UIAlertAction(title: cancelText, style: .cancel)
        alertController.addAction(cancel)
        return alertController
    }
    
    static func inputAlert(
        title: String,
        completion: @escaping (String?)->() = { _ in }
    ) -> UIAlertController {
        var textField: UITextField?
        let alertController = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        alertController.addTextField { textfield in
            textField = textfield
        }
        let confirm = UIAlertAction(title: "Confirm", style: .default) { _ in
            completion(textField?.text)
        }
        alertController.addAction(confirm)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(cancel)
        return alertController
    }
}

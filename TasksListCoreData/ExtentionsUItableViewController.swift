//
//  ExtentionsUItableViewController.swift
//  TasksListCoreData
//
//  Created by Tatiana Dmitrieva on 18/08/2021.
//

import UIKit

extension UITableViewController {
    func showTaskAlert (
                    with title: String,
                    _ message: String,
                    _ actionButtonTitle: String,
                    _ cancelButtonTitle: String,
                    _ placeholder: String,
                    completion: @escaping(String) -> Void) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = placeholder
        }
        let actionButton = UIAlertAction(title: actionButtonTitle, style: .default) { action in
            completion(alertController.textFields?.first?.text ?? "")
        }
        let cancelButton = UIAlertAction(title: cancelButtonTitle, style: .destructive)
        alertController.addAction(actionButton)
        alertController.addAction(cancelButton)
        present(alertController, animated: true)
    }
}

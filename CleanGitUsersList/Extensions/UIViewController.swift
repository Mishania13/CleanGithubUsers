//
//  UIViewController.swift
//  CleanGitUsersList
//
//  Created by Михаил Звягинцев on 23.10.2021.
//

import UIKit

extension UIViewController {
    
    func showAlert(title: String, message: String, action: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ок", style: .cancel) { _ in
            if let action = action {
                action()
            }
        }
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
}

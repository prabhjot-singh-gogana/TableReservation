//
//  UIView+Extension.swift
//  TableReservation
//
//  Created by Prabhjot Singh Gogana on 31/8/2022.
//

import UIKit

extension UIAlertController {
    static func alert(title: String? = nil, message: String? = nil, okTap: (() -> Void)? = nil) -> UIAlertController {
        let alert = UIAlertController(title: title ?? "Alert", message: message ?? "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { (action) in
            okTap?()
        }))
        
        return alert
    }
}

extension UINavigationController {
    func popToRoot() {
        self.popToRootViewController(animated: true)
    }
    func pop() {
        self.popViewController(animated: true)
    }
}

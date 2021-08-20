//
//  Alert+Extentions.swift
//  MVVMBase
//
//  Created by Viet Anh on 20/08/2021.
//

import UIKit

extension UIViewController {
    
    class func loadFromStoryboard() -> Self {
        return instantiateFromStoryboardHelper(self.className)
    }

    fileprivate class func instantiateFromStoryboardHelper<T>(_ name: String) -> T {
        let storyboard = UIStoryboard(name: name, bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: String(describing: self)) as! T
        return controller
    }
    
    //show message
    func showMessage(_ title: String,_ message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
}


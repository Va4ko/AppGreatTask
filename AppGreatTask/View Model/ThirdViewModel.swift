//
//  ThirdViewModel.swift
//  AppGreatTask
//
//  Created by Vachko on 28.07.21.
//

import Foundation
import UIKit

class ThirdViewModel {
    
    let intArray = [1, 2, 4, 6, 8, 12, 13, 16, 20, 22, 28, 34, 38, 45, 56, 58, 60, 61, 62, 70, 71, 72, 74, 75, 80, 85, 87, 90, 99, 100]
    
    var iterations = 0
    
    func search(input: Int, completion: @escaping () -> Void) {
        iterations = 0
        if intArray.contains(input) {
            DispatchQueue.global(qos: .userInitiated).async {
                for int in self.intArray {
                    self.iterations += 1
                    if int == input {
                        DispatchQueue.main.async {
                            completion()
                        }
                        return
                    }
                }
            }
        } else {
            self.popAlert("The entered integer does not exist in the array. Please try with another.")
        }
        
    }
    
    func popAlert(_ message: String) {
        DispatchQueue.main.async {
            let viewController = self.currentVC()
            let alert = UIAlertController(title: "Attention!", message: message, preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default){ _ in
                alert.dismiss(animated: true, completion: nil)
            }
            
            alert.addAction(action)
            viewController.present(alert, animated: true)
        }
    }
    
    func currentVC() -> UIViewController {
        
        let keyWindow = UIWindow.key
        var currentViewCtrl: UIViewController = keyWindow!.rootViewController!
        while (currentViewCtrl.presentedViewController != nil) {
            currentViewCtrl = currentViewCtrl.presentedViewController!
        }
        
        return currentViewCtrl
    }
    
    
}

//
//  ThirdViewController.swift
//  AppGreatTask
//
//  Created by Vachko on 28.07.21.
//

import UIKit

class ThirdViewController: UIViewController {
    
    private let viewModel = ThirdViewModel()
    
    @IBOutlet weak var userInput: UITextField!
    @IBOutlet weak var resultTitle: UILabel!
    @IBOutlet weak var findBtn: UIButton!
    
    @IBAction func button(_ sender: Any) {
        find()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userInput.becomeFirstResponder()
        
        self.hideKeyboardWhenTappedAround()
        
        setUI()
    }
    
    func find() {
        if userInput.text != nil {
            guard let userInput = userInput.text else { return }
            guard let userInputInt = Int(userInput) else { return }
            viewModel.search(input: userInputInt, completion: {
                self.resultTitle.text = "To find number \(userInputInt), \(self.viewModel.iterations) iterations were used!"
            })
        }
    }
    
    // MARK: - UI Update
    
    private func setUI() {
        findBtn.layer.borderWidth = 1
        findBtn.layer.borderColor = UIColor.white.cgColor
        findBtn.layer.masksToBounds = false
        findBtn.layer.cornerRadius = 20
        findBtn.clipsToBounds = true
        
        setBackground(named: "thirdBackgound")
        
    }
    
}

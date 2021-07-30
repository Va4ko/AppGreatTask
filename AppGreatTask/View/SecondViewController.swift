//
//  SecondViewController.swift
//  AppGreatTask
//
//  Created by Vachko on 28.07.21.
//

import UIKit
import GoogleSignIn

class SecondViewController: UIViewController {
    
    private let viewModel = SecondViewModel()
    
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var logIn: UIButton!
    @IBOutlet weak var logOut: UIButton!
    
    @IBAction func logInBtn(_ sender: Any) {
        viewModel.signIn(presentingVC: self, completion: {
            self.setUI()
        })
    }
    
    @IBAction func logOutBtn(_ sender: Any) {
        viewModel.signOut(completion: {
            self.setUI()
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchUser(completion: {
            self.setUI()
        })
    }
    
    // MARK: - UI Update
    
    func setUI() {
        logIn.isHidden = viewModel.logInHidden!
        logOut.isHidden = viewModel.logOutHidden!
        avatar.image = viewModel.avatarImg!
        
        avatar.layer.borderWidth = 1
        avatar.layer.borderColor = UIColor.white.cgColor
        avatar.layer.masksToBounds = false
        avatar.layer.cornerRadius = avatar.frame.height / 2
        avatar.clipsToBounds = true
        
        setBackground(named: "secondBackground")
    }
    
}

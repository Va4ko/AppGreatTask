//
//  VeryFirstViewController.swift
//  AppGreatTask
//
//  Created by Vachko on 30.07.21.
//

import UIKit

class VeryFirstViewController: UIViewController {
    
    @IBOutlet weak var welcomeTextView: UITextView!
    @IBOutlet weak var enjoyBtn: UIButton!
    
    @IBAction func enjoy(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mainViewController = storyboard.instantiateViewController(identifier: "MainViewController")
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainViewController)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        enjoyBtn.layer.borderWidth = 1
        enjoyBtn.layer.borderColor = UIColor.white.cgColor
        enjoyBtn.layer.masksToBounds = false
        enjoyBtn.layer.cornerRadius = 15
        enjoyBtn.clipsToBounds = true
        
        setBackground(named: "firstScreenBackground")
        
        welcomeTextView.text = """
            Hello!

            This is AppGreatTask.
            Welcome to my app that i made for AppGreat.

            You see this because you are opening the app for the very first time!
            Next time, you will start from the application home screen.

            I hope you like it!
            """
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        AppUtility.lockOrientation(.portrait)
        // Or to rotate and lock
        // AppUtility.lockOrientation(.portrait, andRotateTo: .portrait)
        
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Don't forget to reset when view is being removed
        AppUtility.lockOrientation(.all)
    }
    
    
}

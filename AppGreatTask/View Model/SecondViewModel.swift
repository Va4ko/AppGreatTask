//
//  SecondViewModel.swift
//  AppGreatTask
//
//  Created by Vachko on 28.07.21.
//

import Foundation
import UIKit
import GoogleSignIn

class SecondViewModel {
    let signInConfig = GIDConfiguration.init(clientID: "1058178992734-tbubse6j0qqte8024kupgfhq32iismcg.apps.googleusercontent.com")
    
    var imageData: Data?
    var logInHidden: Bool?
    var logOutHidden: Bool?
    var avatarImg: UIImage?
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(from url: URL, completion: @escaping () -> Void) {
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            self.imageData = data
            
            DispatchQueue.main.async {
                completion()
            }
        }
    }
    
    func signIn(presentingVC: UIViewController, completion: @escaping () -> Void) {
        
        GIDSignIn.sharedInstance.signIn(with: signInConfig, presenting: presentingVC) { user, error in
            
            guard error == nil else { return }
            self.logInHidden = true
            self.logOutHidden = false
            
            guard let user = user else { return }
            let profilePicUrl = user.profile?.imageURL(withDimension: 220)
            guard let imageURL = profilePicUrl else { return }
            self.downloadImage(from: imageURL, completion: {
                guard let imageData = self.imageData else { return }
                self.avatarImg = UIImage(data: imageData)
                
                DispatchQueue.main.async {
                    completion()
                }
                
            })
        }
        
    }
    
    func signOut(completion: @escaping () -> Void) {
        GIDSignIn.sharedInstance.signOut()
        self.logInHidden = false
        self.logOutHidden = true
        self.avatarImg = UIImage(named: "avatar")
        
        DispatchQueue.main.async {
            completion()
        }
    }
    
    func fetchUser(completion: @escaping () -> Void) {
        GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
            
            if error != nil || user == nil {
                self.logInHidden = false
                self.logOutHidden = true
                self.avatarImg = UIImage(named: "avatar")
                
                DispatchQueue.main.async {
                    completion()
                }
                
            } else {
                
                self.logInHidden = true
                self.logOutHidden = false
                
                guard let user = user else { return }
                let profilePicUrl = user.profile?.imageURL(withDimension: 220)
                guard let imageData = profilePicUrl else { return }
                self.downloadImage(from: imageData, completion: {
                    self.avatarImg = UIImage(data: self.imageData!)
                    
                    DispatchQueue.main.async {
                        completion()
                    }
                    
                })
            }
        }
    }
    
}

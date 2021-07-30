//
//  ImageViewController.swift
//  AppGreatTask
//
//  Created by Vachko on 28.07.21.
//

import UIKit

class ImageViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = image
        
    }
    
}

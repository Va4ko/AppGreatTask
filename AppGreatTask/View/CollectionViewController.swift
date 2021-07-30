//
//  CollectionViewController.swift
//  AppGreatTask
//
//  Created by Vachko on 28.07.21.
//

import UIKit
import Kingfisher

private let reuseIdentifier = "Cell"
private var cellColor = true

class CollectionViewController: UICollectionViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Register cell classes
        //        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        // Do any additional setup after loading the view.
    }
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showImage",
           let destination = segue.destination as? ImageViewController {
            if let cell = sender as? UICollectionViewCell, let indexPath = self.collectionView.indexPath(for: cell)  {
                destination.title = "Image"
                
                let urls = ImageLoader.sampleImageURLs
                let url = urls[indexPath.row % urls.count]
                let resource = ImageResource(downloadURL: url, cacheKey: "key-\(indexPath.row)")
                
                KingfisherManager.shared.retrieveImage(with: resource) { result in
                    switch result {
                    case .success(let value):
                        print("Image: \(value.image). Got from: \(value.cacheType)")
                        destination.image = value.image
                    case .failure(let error):
                        print("Error: \(error)")
                    }
                }
                
            }
        }
    }
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ImageLoader.sampleImageURLs.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CollectionViewCell
        
        let urls = ImageLoader.sampleImageURLs
        let url = urls[indexPath.row % urls.count]
        
        let resource = ImageResource(downloadURL: url, cacheKey: "key-\(indexPath.row)")
        KF.resource(resource).set(to: cell.imageView)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.current.orientation.isPortrait,
           let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            let width = (self.view.frame.size.width / 2) - 15
            layout.itemSize = CGSize(width: width, height: width)
            layout.invalidateLayout()
        } else if UIDevice.current.orientation.isLandscape,
        let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            let width = (self.view.frame.size.width / 2) - 15
            layout.itemSize = CGSize(width: width, height: width)
            layout.invalidateLayout()
        }
    }
    
    // MARK: UICollectionViewDelegate
    
    //        override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    //
    //        }
    
    /*
     // Uncomment this method to specify if the specified item should be highlighted during tracking
     override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment this method to specify if the specified item should be selected
     override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
     override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
     
     }
     */
    
}

extension CollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (self.view.frame.size.width / 2) - 15
        return CGSize(width: width, height: width)
    }
    
}

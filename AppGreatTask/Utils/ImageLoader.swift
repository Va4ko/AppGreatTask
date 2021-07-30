//
//  ImageLoader.swift
//  AppGreatTask
//
//  Created by Vachko on 29.07.21.
//

import Foundation

struct ImageLoader {
    
    static let sampleImageURLs: [URL] = {
        let prefix = "https://vehiclediary.000webhostapp.com/Images"
        return (1...20).map { URL(string: "\(prefix)/\($0).jpg")! }
    }()
    
}

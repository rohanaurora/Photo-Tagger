//
//  ImageCell.swift
//  CodeChallenge
//
//  Created by Rohan Aurora on 9/15/20.
//  Copyright © 2020 Hootsuite. All rights reserved.
//

import UIKit

class ImageCell: UICollectionViewCell {
    
    static let cellID:String = "imageCell"
    
    @IBOutlet weak var imageView: UIImageView!
    
    var datasource: TaggedImage? {
        didSet { updateUI() }
    }
    
    private func updateUI() {
        if let url = datasource?.url {
            ImageStore.shared.getImage(url: url, completion: { result in
                switch result {
                case .success(let image):
                    self.imageView.image = image
                case .failure( _): break
                }
            })
        }
    }
}

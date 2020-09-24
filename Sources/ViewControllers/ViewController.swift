//  Copyright © 2018 Hootsuite. All rights reserved.

import UIKit

class ViewController: UIViewController {

    @IBOutlet private weak var tagLabel: UILabel!
    @IBOutlet private weak var collectionView: UICollectionView!

    @IBAction private func refreshButtonTapped(_ sender: UIBarButtonItem) {
        loadImages()
    }
    
    var datasource: ImagesViewModel?
    static let imageLimit = 4
    
    override func viewDidLoad() {
        datasource = ImagesViewModel()
        loadImages()
    }
    
    private func loadImages() {
        datasource?.loadData(completion: {
            DispatchQueue.main.async { [weak self] in
                self?.tagLabel.text = self?.datasource?.imageTags
                self?.collectionView.reloadData()
            }
        })
    }
}
    
extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ViewController.imageLimit
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCell.cellID, for: indexPath) as! ImageCell
        
        if let taggedImage = datasource?.taggedImages?[indexPath.row] {
            cell.datasource = taggedImage
        }
        return cell
    }
}

//
//  ViewController.swift
//  Photos
//
//  Created by 백상휘 on 2022/03/21.
//

import UIKit

class PhotoViewController: UIViewController {
    @IBOutlet weak var PhotoCollectionView: UICollectionView!
    var numberOfItem = 40
    
    private let photoThumbnailManager = PhotoThumbnailManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        PhotoCollectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier)
        
        photoThumbnailManager.setImages {
            DispatchQueue.main.async {
                self.PhotoCollectionView.reloadData()
            }
        }
    }
}

extension PhotoViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoThumbnailManager.thumbnailsCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier, for: indexPath) as? PhotoCollectionViewCell,
                let image = photoThumbnailManager[indexPath.row] else { return PhotoCollectionViewCell() }
        cell.setImage(image)
        
        return cell
    }
    
    private func getRandomColor() -> UIColor {
        UIColor(
            red: CGFloat(Float.random(in: 0...1)),
            green: CGFloat(Float.random(in: 0...1)),
            blue: CGFloat(Float.random(in: 0...1)),
            alpha: 1.0
        )
    }
}

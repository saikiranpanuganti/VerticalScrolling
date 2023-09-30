//
//  TestViewController.swift
//  VerticalScrolling
//
//  Created by Saikiran Panuganti on 30/09/23.
//

import UIKit

class TestViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var heights: [CGFloat] = [400, 500, 300, 400, 500, 400, 400, 500, 600, 400, 500, 300, 400, 500, 400, 400, 500, 600, 400, 500, 200, 400, 500, 400, 400, 500, 600, 400, 200, 300, 200, 500, 400, 400, 500, 600, 400, 500, 300, 400, 500, 400, 400, 500, 600, 400, 500, 300, 400, 500, 400, 400, 500, 600, 400, 500, 300, 400, 500, 400, 400, 500, 600, 400, 500, 300, 400, 500, 400, 400, 500, 600, 400, 500, 300, 400, 500, 400, 400, 500, 600, 400, 500, 300, 400, 500, 400, 400, 500, 600, 400, 500, 300, 400, 500, 400, 400, 500, 600, 400, 500, 300, 400, 500, 400, 400, 500, 600, 400, 500, 300, 400, 500, 400, 400, 500, 600, 400, 500, 300, 400, 500, 400, 400, 500, 600, 400, 500, 300, 400, 500, 400, 400, 500, 600, 400, 500, 300, 400, 500, 400, 400, 500, 600, 400, 500, 300, 400, 500, 400, 400, 500, 600, 400, 500, 300, 400, 500, 400, 400, 500, 600, 400, 500, 300, 400, 500, 400, 400, 500, 600, 400, 500, 300, 400, 500, 400, 400, 500, 600, 400, 500, 300, 400, 500, 400, 400, 500, 600, 400, 500, 300, 400, 500, 400, 400, 500, 600, 400, 500, 300, 400, 500, 400, 400, 500, 600, 400, 500, 300, 400, 500, 400, 400, 500, 600, 400, 500, 300, 400, 500, 400, 400, 500, 600, 400, 500, 300, 400, 500, 400, 400, 500, 600, 400, 500, 300, 400, 500, 400, 400, 500, 600, 400, 500, 300, 400, 500, 400, 400, 500, 600, 400, 500, 300, 400, 500, 400, 400, 500, 600, 400, 500, 300, 400, 500, 400, 400, 500, 600, 400, 500, 300, 400, 500, 400, 400, 500, 600, 400, 500, 300, 400, 500, 400, 400, 500, 600, 400, 500, 300, 400, 500, 400, 400, 500, 600, 400, 500, 300, 400, 500, 400, 400, 500, 600, 400, 500, 300, 400, 500, 400, 400, 500, 600, 400, 500, 300, 400, 500, 400, 400, 500, 600, 400, 500, 300, 400, 500, 400, 400, 500, 600, 400, 500, 300, 400, 500, 400, 400, 500, 600, 400, 500, 300, 400, 500, 400, 400, 500, 600, 400, 500, 300, 400, 500, 400, 400, 500, 600, 400, 500, 300, 400, 500, 400, 400, 500, 600, 400, 500, 300, 400, 500, 400, 400, 500, 600]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let layout = collectionView?.collectionViewLayout as? HomeCollectionViewFlowLayout {
          layout.delegate = self
        }
        collectionView.register(UINib(nibName: "ImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ImageCollectionViewCell")
        collectionView.dataSource = self
        collectionView.delegate = self
    }

}

extension TestViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 300
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell", for: indexPath) as? ImageCollectionViewCell {
            cell.configureUI(index: indexPath.item)
            
            return cell
        }
        return UICollectionViewCell()
    }
}

extension TestViewController: UICollectionViewDelegate {
    
}

extension TestViewController: HomeCollectionViewFlowLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForItemAtIndexPath indexPath:IndexPath) -> CGFloat {
        return heights[indexPath.item]
    }
}

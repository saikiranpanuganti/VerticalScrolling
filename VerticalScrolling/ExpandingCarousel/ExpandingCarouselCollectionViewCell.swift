//
//  ExpandingCarouselCollectionViewCell.swift
//  VerticalScrolling
//
//  Created by saikiran panuganti on 21/11/23.
//

import UIKit

class ExpandingCarouselCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override var preferredFocusEnvironments: [UIFocusEnvironment] {
        return [collectionView]
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 50, bottom: 0, right: 0)
        collectionView.remembersLastFocusedIndexPath = true
        collectionView.register(UINib(nibName: "ExpandingCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ExpandingCollectionViewCell")
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func configureUI(index: Int, homeData: HomeDataModel) {
        titleLabel.text = "Expanding Carousel \(index)"
        collectionView.reloadData()
    }
}


extension ExpandingCarouselCollectionViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 300
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ExpandingCollectionViewCell", for: indexPath) as? ExpandingCollectionViewCell {
            cell.configureUI(index: indexPath.item)
            return cell
        }
        return UICollectionViewCell()
    }
}

extension ExpandingCarouselCollectionViewCell: UICollectionViewDelegate {
    
}

extension ExpandingCarouselCollectionViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 300)
    }
}

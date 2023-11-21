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
    
    var expandingCollectionViewLayout: ExpandingCollectionViewFlowLayout? {
        return collectionView.collectionViewLayout as? ExpandingCollectionViewFlowLayout
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
    
    func collectionView(_ collectionView: UICollectionView, canFocusItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldUpdateFocusIn context: UICollectionViewFocusUpdateContext) -> Bool {
        if let indexPath = context.nextFocusedIndexPath, let cell = collectionView.cellForItem(at: indexPath) {
            let cellCenter = CGPoint(x: cell.bounds.origin.x, y: cell.bounds.origin.y)
            let cellLocation = cell.convert(cellCenter, to: collectionView)
            if let collectionViewLayoutMpx = collectionView.collectionViewLayout as? ExpandingCollectionViewFlowLayout {
                collectionViewLayoutMpx.preferredPositionShouldX = cellLocation.x - 50
            }
        }
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, didUpdateFocusIn context: UICollectionViewFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        if let indexPath = context.nextFocusedIndexPath, let cell = collectionView.cellForItem(at: indexPath) {
            let cellCenter = CGPoint(x: cell.bounds.origin.x, y: cell.bounds.origin.y)
            let cellLocation = cell.convert(cellCenter, to: collectionView)
            if let collectionViewLayoutMpx = collectionView.collectionViewLayout as? ExpandingCollectionViewFlowLayout {
                collectionViewLayoutMpx.preferredPositionDidX = cellLocation.x - 50
            }
        }
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

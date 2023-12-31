//
//  CarouselCollectionViewCell.swift
//  VerticalScrolling
//
//  Created by SaiKiran Panuganti on 24/09/23.
//

import UIKit

class CarouselCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var carouselCollectionView: UICollectionView!
    
    var focusedIndex: IndexPath? = IndexPath(item: 0, section: 0)
    
    override var preferredFocusEnvironments: [UIFocusEnvironment] {
        return [carouselCollectionView]
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        carouselCollectionView.contentInset = UIEdgeInsets(top: 0, left: 50, bottom: 0, right: 0)
        carouselCollectionView.remembersLastFocusedIndexPath = true
        carouselCollectionView.register(UINib(nibName: "ImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ImageCollectionViewCell")
        carouselCollectionView.dataSource = self
        carouselCollectionView.delegate = self
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
//        carouselCollectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .left, animated: false)
    }
    
    func configureUI(index: Int, homeData: HomeDataModel) {
        if let collectionViewLayout = carouselCollectionView.collectionViewLayout as? CarouselCollectionViewFlowLayout {
            collectionViewLayout.cellSize = CGSize(width: self.frame.height - 70, height: self.frame.height - 70)
        }
        titleLabel.text = "Carousel \(index)"
        carouselCollectionView.reloadData()
    }
    
    func moveFocus(toIndexPath: IndexPath) {
        if toIndexPath.item > 0 && toIndexPath.item < 300 {
            focusedIndex = toIndexPath
            carouselCollectionView.setNeedsFocusUpdate()
            carouselCollectionView.updateFocusIfNeeded()
        }
    }
    
    func indexPathForPreferredFocusedView(in collectionView: UICollectionView) -> IndexPath? {
        return focusedIndex
    }
    
    func getFullyVisibleCells(collectionView: UICollectionView) -> [IndexPath] {
        let visibleIndexPaths = collectionView.indexPathsForVisibleItems.sorted { $0.item < $1.item }
        return visibleIndexPaths.filter { indexPath in
            let layoutAttribute = collectionView.layoutAttributesForItem(at: indexPath)!
            let cellFrame = layoutAttribute.frame
            let isCellFullyVisible = collectionView.bounds.contains(cellFrame)
            return isCellFullyVisible
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, canFocusItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldUpdateFocusIn context: UICollectionViewFocusUpdateContext) -> Bool {
        if let indexPath = context.nextFocusedIndexPath, let cell = collectionView.cellForItem(at: indexPath) {
            let cellCenter = CGPoint(x: cell.bounds.origin.x, y: cell.bounds.origin.y)
            let cellLocation = cell.convert(cellCenter, to: collectionView)
            if let collectionViewLayout = carouselCollectionView.collectionViewLayout as? CarouselCollectionViewFlowLayout {
                collectionViewLayout.preferredPositionShouldX = cellLocation.x - 50
            }else if let collectionViewLayoutMpx = carouselCollectionView.collectionViewLayout as? MpxCollectionViewLayout {
                collectionViewLayoutMpx.preferredPositionShouldX = cellLocation.x - 50
            }
        }
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, didUpdateFocusIn context: UICollectionViewFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        if let indexPath = context.nextFocusedIndexPath, let cell = collectionView.cellForItem(at: indexPath) {
            let cellCenter = CGPoint(x: cell.bounds.origin.x, y: cell.bounds.origin.y)
            let cellLocation = cell.convert(cellCenter, to: collectionView)
            if let collectionViewLayout = carouselCollectionView.collectionViewLayout as? CarouselCollectionViewFlowLayout {
                collectionViewLayout.preferredPositionShouldX = cellLocation.x - 50
            }else if let collectionViewLayoutMpx = carouselCollectionView.collectionViewLayout as? MpxCollectionViewLayout {
                collectionViewLayoutMpx.preferredPositionShouldX = cellLocation.x - 50
            }
        }
    }
}

extension CarouselCollectionViewCell: UICollectionViewDataSource {
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

extension CarouselCollectionViewCell: UICollectionViewDelegate {
    
}

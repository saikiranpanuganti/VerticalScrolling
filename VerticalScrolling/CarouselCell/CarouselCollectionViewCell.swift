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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        carouselCollectionView.contentInset = UIEdgeInsets(top: 0, left: 50, bottom: 0, right: 0)
        carouselCollectionView.remembersLastFocusedIndexPath = false
        carouselCollectionView.register(UINib(nibName: "ImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ImageCollectionViewCell")
        carouselCollectionView.dataSource = self
        carouselCollectionView.delegate = self
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        carouselCollectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .left, animated: false)
    }
    
    func configureUI(index: Int) {
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
    
    func collectionView(_ collectionView: UICollectionView, shouldUpdateFocusIn context: UICollectionViewFocusUpdateContext) -> Bool {
        if let indexPath = context.nextFocusedIndexPath, let cell = collectionView.cellForItem(at: indexPath) {
            let cellCenter = CGPoint(x: cell.bounds.origin.x, y: cell.bounds.origin.y)
            let cellLocation = cell.convert(cellCenter, to: collectionView)
            if let collectionViewLayout = carouselCollectionView.collectionViewLayout as? CarouselCollectionViewFlowLayout {
                collectionViewLayout.preferredPositionShouldX = cellLocation.x - 50
            }
            if context.previouslyFocusedView?.superview !== context.nextFocusedView?.superview && ((context.previouslyFocusedView as? MenuTableViewCell) == nil) {
                let fullyVisibleIndexPaths = getFullyVisibleCells(collectionView: collectionView)
                print("Horizontal returning false visibleIndexPaths - \(fullyVisibleIndexPaths) nextIndexPath - \(context.nextFocusedIndexPath)")
                if fullyVisibleIndexPaths.count > 0,
                   context.nextFocusedIndexPath != fullyVisibleIndexPaths.first {
                    moveFocus(toIndexPath: fullyVisibleIndexPaths.first ?? IndexPath(item: 0, section: 0))
                    return false
                }
            }
            print("$$Horizontal Carousel: shouldUpdateFocusIn x - \(cellLocation.x - 50) ms - \(Date().timeIntervalSince1970*1000)")
        }
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, didUpdateFocusIn context: UICollectionViewFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        if let indexPath = context.nextFocusedIndexPath, let cell = collectionView.cellForItem(at: indexPath) {
            let cellCenter = CGPoint(x: cell.bounds.origin.x, y: cell.bounds.origin.y)
            let cellLocation = cell.convert(cellCenter, to: collectionView)
            if let collectionViewLayout = carouselCollectionView.collectionViewLayout as? CarouselCollectionViewFlowLayout {
                collectionViewLayout.preferredPositionShouldX = cellLocation.x - 50
            }
            
            if context.previouslyFocusedView?.superview !== context.nextFocusedView?.superview {
                print("Horizontal different instances - \(collectionView.indexPathsForVisibleItems)")
            }else {
                print("Horizontal same instances")
            }
            //            AppData.shared.preferredPositionDidX = cellLocation.x
            print("$$Horizontal Carousel: didUpdateFocusIn x - \(cellLocation.x - 50) ms - \(Date().timeIntervalSince1970*1000)")
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

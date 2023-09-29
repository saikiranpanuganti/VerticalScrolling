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
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        carouselCollectionView.register(UINib(nibName: "ImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ImageCollectionViewCell")
        carouselCollectionView.dataSource = self
        carouselCollectionView.delegate = self
    }
    
    
//     Option 1
    override func prepareForReuse() {
        super.prepareForReuse()

        carouselCollectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .left, animated: false)
    }
    
    func configureUI(index: Int) {
        if let collectionViewLayout = carouselCollectionView.collectionViewLayout as? CustomHorizontalCollectionViewFlowLayout {
            if index%2 == 0 {
                collectionViewLayout.cellSize = CGSize(width: 300, height: 300)
            }else {
                collectionViewLayout.cellSize = CGSize(width: 400, height: 300)
            }
        }
        titleLabel.text = "Carousel \(index)"
        carouselCollectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldUpdateFocusIn context: UICollectionViewFocusUpdateContext) -> Bool {
        if let indexPath = context.nextFocusedIndexPath, let cell = collectionView.cellForItem(at: indexPath) {
            let cellCenter = CGPoint(x: cell.bounds.origin.x, y: cell.bounds.origin.y)
            let cellLocation = cell.convert(cellCenter, to: collectionView)
            if let collectionViewLayout = carouselCollectionView.collectionViewLayout as? CustomHorizontalCollectionViewFlowLayout {
                collectionViewLayout.preferredPositionShouldX = cellLocation.x
            }
            if context.previouslyFocusedView?.superview !== context.nextFocusedView?.superview && ((context.previouslyFocusedView as? MenuTableViewCell) == nil) {
                let visibleIndexPaths = collectionView.indexPathsForVisibleItems
                if context.nextFocusedIndexPath != visibleIndexPaths.first {
                    print("Horizontal returning false")
                    return false
                }
                print("Horizontal different instances - \(collectionView.indexPathsForVisibleItems)")
            }
//            AppData.shared.preferredPositionShouldX = cellLocation.x
            print("$$Horizontal Carousel: shouldUpdateFocusIn x - \(cellLocation.x) ms - \(Date().timeIntervalSince1970*1000)")
        }
        return true
    }

    func collectionView(_ collectionView: UICollectionView, didUpdateFocusIn context: UICollectionViewFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        if let indexPath = context.nextFocusedIndexPath, let cell = collectionView.cellForItem(at: indexPath) {
            let cellCenter = CGPoint(x: cell.bounds.origin.x, y: cell.bounds.origin.y)
            let cellLocation = cell.convert(cellCenter, to: collectionView)
            if let collectionViewLayout = carouselCollectionView.collectionViewLayout as? CustomHorizontalCollectionViewFlowLayout {
                collectionViewLayout.preferredPositionShouldX = cellLocation.x
            }
            
            if context.previouslyFocusedView?.superview !== context.nextFocusedView?.superview {
                print("Horizontal different instances - \(collectionView.indexPathsForVisibleItems)")
            }else {
                print("Horizontal same instances")
            }
//            AppData.shared.preferredPositionDidX = cellLocation.x
            print("$$Horizontal Carousel: didUpdateFocusIn x - \(cellLocation.x) ms - \(Date().timeIntervalSince1970*1000)")
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

//
//  PromoCollectionViewCell.swift
//  VerticalScrolling
//
//  Created by Saikiran Panuganti on 06/10/23.
//

import UIKit

class PromoCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var promoCollectionView: UICollectionView!
    
    var focusedIndex: IndexPath? = IndexPath(item: 0, section: 0)
    var promoCellWidth:CGFloat = 300
    
    override func awakeFromNib() {
        super.awakeFromNib()
        promoCollectionView.contentInset = UIEdgeInsets(top: 0, left: PromoCellProps.leftInset, bottom: 0, right: 0)
        promoCollectionView.remembersLastFocusedIndexPath = false
        promoCollectionView.register(UINib(nibName: "PromoImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PromoImageCollectionViewCell")
//        promoCollectionView.decelerationRate = .fast
        promoCollectionView.dataSource = self
        promoCollectionView.delegate = self
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        promoCollectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .left, animated: false)
    }
    
    func configureUI(index: Int, homeData: HomeDataModel) {
        if let collectionViewLayout = promoCollectionView.collectionViewLayout as? MpxCollectionViewLayout {
            promoCellWidth = self.frame.height - 80
            collectionViewLayout.cellWidth = promoCellWidth
        }
        titleLabel.text = "Mpx Carousel \(index)"
        promoCollectionView.reloadData()
    }
    
    func moveFocus(toIndexPath: IndexPath) {
        if toIndexPath.item > 0 && toIndexPath.item < 300 {
            focusedIndex = toIndexPath
            promoCollectionView.setNeedsFocusUpdate()
            promoCollectionView.updateFocusIfNeeded()
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
            if let collectionViewLayoutMpx = promoCollectionView.collectionViewLayout as? MpxCollectionViewLayout {
                print("$$Promo: shouldUpdateFocusIn >0 indexPath.item - \(indexPath.item) promoCellWidth - \(promoCellWidth) preferredPositionShouldX - \(((promoCellWidth + PromoCellProps.cellPadding)*CGFloat(indexPath.item)) - PromoCellProps.leftInset)")
                collectionViewLayoutMpx.preferredPositionShouldX = ((promoCellWidth + PromoCellProps.cellPadding)*CGFloat(indexPath.item)) - PromoCellProps.leftInset
            }
            if context.previouslyFocusedView?.superview !== context.nextFocusedView?.superview && ((context.previouslyFocusedView as? MenuTableViewCell) == nil) {
                let fullyVisibleIndexPaths = getFullyVisibleCells(collectionView: collectionView)
                if fullyVisibleIndexPaths.count > 0,
                   context.nextFocusedIndexPath != fullyVisibleIndexPaths.first {
                    moveFocus(toIndexPath: fullyVisibleIndexPaths.first ?? IndexPath(item: 0, section: 0))
                    return false
                }
            }
        }
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, didUpdateFocusIn context: UICollectionViewFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        if let indexPath = context.nextFocusedIndexPath, let cell = collectionView.cellForItem(at: indexPath) {
            let cellCenter = CGPoint(x: cell.bounds.origin.x, y: cell.bounds.origin.y)
            let cellLocation = cell.convert(cellCenter, to: collectionView)
            if let collectionViewLayoutMpx = promoCollectionView.collectionViewLayout as? MpxCollectionViewLayout {
                print("$$Promo: didUpdateFocusIn >0 indexPath.item - \(indexPath.item) promoCellWidth - \(promoCellWidth) preferredPositionDidX - \(((promoCellWidth + PromoCellProps.cellPadding)*CGFloat(indexPath.item)) - PromoCellProps.leftInset)")
                collectionViewLayoutMpx.preferredPositionDidX = ((promoCellWidth + PromoCellProps.cellPadding)*CGFloat(indexPath.item)) - PromoCellProps.leftInset
            }
        }
    }
}

extension PromoCollectionViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 500
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PromoImageCollectionViewCell", for: indexPath) as? PromoImageCollectionViewCell {
            cell.configureUI(index: indexPath.item)
            
            return cell
        }
        return UICollectionViewCell()
    }
}

extension PromoCollectionViewCell: UICollectionViewDelegate {
    
}

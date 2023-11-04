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
    @IBOutlet weak var promoMetaDataView: UIView!
    @IBOutlet weak var promoMetaDataLeading: NSLayoutConstraint!
    @IBOutlet weak var promoMetaDataWidth: NSLayoutConstraint!
    @IBOutlet weak var borderView: UIView!
    @IBOutlet weak var borderLeading: NSLayoutConstraint!
    @IBOutlet weak var borderWidth: NSLayoutConstraint!
    @IBOutlet weak var metaDataLabel: UILabel!
    
    var metaDataTimer: Timer?
    var focusedIndex: IndexPath? = IndexPath(item: 0, section: 0)
    var promoCollectionViewLayout: MpxCollectionViewLayout? {
        return promoCollectionView.collectionViewLayout as? MpxCollectionViewLayout
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        borderLeading.constant = PromoCellProps.leftInset
        borderWidth.constant = PromoCellProps.cellWidth
        promoMetaDataLeading.constant = PromoCellProps.leftInset + PromoCellProps.cellWidth
        promoMetaDataWidth.constant = PromoCellProps.featuredCellWidth - PromoCellProps.cellWidth
        promoMetaDataView.alpha = 0
        borderView.alpha = 0
        promoCollectionView.contentInset = UIEdgeInsets(top: 0, left: PromoCellProps.leftInset, bottom: 0, right: 0)
        promoCollectionView.remembersLastFocusedIndexPath = false
        promoCollectionView.register(UINib(nibName: "PromoImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PromoImageCollectionViewCell")
        promoCollectionView.dataSource = self
        promoCollectionView.delegate = self
        setUpBorderView()
    }
    
    func setUpBorderView() {
        borderView.layer.borderWidth = 5
        borderView.layer.borderColor = UIColor.orange.cgColor
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        promoCollectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .left, animated: false)
    }
    
    func configureUI(index: Int, homeData: HomeDataModel) {
        if let collectionViewLayout = promoCollectionViewLayout {
            collectionViewLayout.cellWidth = PromoCellProps.cellWidth
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
    
    func cleanMetaDataTimer() {
        metaDataTimer?.invalidate()
        metaDataTimer = nil
    }
    
    func setMetaData() {
        cleanMetaDataTimer()
        metaDataLabel.text = ""
        metaDataTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: { [weak self] timer in
            self?.cleanMetaDataTimer()
            if let xOffset = self?.promoCollectionView.contentOffset.x {
                let currentIndex = (xOffset + PromoCellProps.leftInset)/(PromoCellProps.cellWidth + PromoCellProps.cellPadding)
                print("xOffset - \(xOffset) currentIndex - \(currentIndex)")
                self?.metaDataLabel.text = "Index - \(Int(currentIndex))"
            }
        })
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
                collectionViewLayoutMpx.preferredPositionShouldX = ((PromoCellProps.cellWidth + PromoCellProps.cellPadding)*CGFloat(indexPath.item)) - PromoCellProps.leftInset
            }
            if context.previouslyFocusedView?.superview !== context.nextFocusedView?.superview && ((context.previouslyFocusedView as? MenuTableViewCell) == nil) {
                let fullyVisibleIndexPaths = getFullyVisibleCells(collectionView: collectionView)
                if fullyVisibleIndexPaths.count > 0,
                   context.nextFocusedIndexPath != fullyVisibleIndexPaths.first {
                    moveFocus(toIndexPath: fullyVisibleIndexPaths.first ?? IndexPath(item: 0, section: 0))
//                    return false
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
                collectionViewLayoutMpx.preferredPositionDidX = ((PromoCellProps.cellWidth + PromoCellProps.cellPadding)*CGFloat(indexPath.item)) - PromoCellProps.leftInset
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
            cell.delegate = self
            cell.configureUI(index: indexPath.item)
            return cell
        }
        return UICollectionViewCell()
    }
}

extension PromoCollectionViewCell: UICollectionViewDelegate {
    
}

extension PromoCollectionViewCell: PromoImageCollectionViewCellDelegate {
    func cellFocussed() {
        borderView.alpha = 1
        UIView.animate(withDuration: 0.5, delay: 0.75) {
            self.promoMetaDataView.alpha = 1
        }
        setMetaData()
    }
    
    func cellUnFocussed() {
        cleanMetaDataTimer()
        borderView.alpha = 0
        promoMetaDataView.alpha = 0
    }
}

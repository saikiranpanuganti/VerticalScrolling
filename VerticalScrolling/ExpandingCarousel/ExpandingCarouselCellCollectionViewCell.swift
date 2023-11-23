//
//  ExpandingCarouselCellCollectionViewCell.swift
//  VerticalScrolling
//
//  Created by saikiran panuganti on 22/11/23.
//

import UIKit

class ExpandingCarouselCellCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var lastFocussedIndexPath: IndexPath? = nil
    var focussedCellWidth: CGFloat = AppConstants.expandingCellWidth
    var unFocussedCellWidth: CGFloat = AppConstants.expandingCellWidth
    var cellHeight: CGFloat = AppConstants.expandingCellHeight
    
    var playTrailerTimer: Timer?
    var expandingTimer: Timer?
    
    override var preferredFocusEnvironments: [UIFocusEnvironment] {
        return [collectionView]
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 50, bottom: 0, right: 0)
        collectionView.remembersLastFocusedIndexPath = true
        collectionView.register(UINib(nibName: "ExpandingCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ExpandingCollectionViewCell")
        collectionView.isScrollEnabled = false
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func configureUI(index: Int, homeData: HomeDataModel) {
        titleLabel.text = "Expanding Carousel default Layout \(index)"
        collectionView.reloadData()
    }
    
    func playTrailer(indexPath: IndexPath) {
        invalidatePlayTrailerTimer()
        invalidateExpandingTimer()
        
        playTrailerTimer = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false, block: { [weak self] timer in
            self?.invalidatePlayTrailerTimer()
            
            self?.animateCellWidth()
        })
    }
    
    func invalidatePlayTrailerTimer() {
        if playTrailerTimer != nil {
            playTrailerTimer?.invalidate()
            playTrailerTimer = nil
        }
    }
    
    func animateCellWidth() {
        invalidateExpandingTimer()
        
        expandingTimer = Timer.scheduledTimer(withTimeInterval: 0.007, repeats: true, block: { [weak self] timer in
            guard let width = self?.focussedCellWidth else {
                self?.invalidateExpandingTimer()
                return
            }
            
            if width == AppConstants.expandingCellFocussedWidth {
                self?.invalidateExpandingTimer()
            }else {
                self?.focussedCellWidth = width + 10
                self?.collectionView.collectionViewLayout.invalidateLayout()
            }
        })
    }
    
    func invalidateExpandingTimer() {
        if expandingTimer != nil {
            expandingTimer?.invalidate()
            expandingTimer = nil
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, canFocusItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldUpdateFocusIn context: UICollectionViewFocusUpdateContext) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, didUpdateFocusIn context: UICollectionViewFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        if let indexPath = context.previouslyFocusedIndexPath {
            lastFocussedIndexPath = nil
        }
        if let indexPath = context.nextFocusedIndexPath, let cell = collectionView.cellForItem(at: indexPath) {
            lastFocussedIndexPath = indexPath
            focussedCellWidth = AppConstants.expandingCellWidth
            self.playTrailer(indexPath: indexPath)
            
            let cellCenter = CGPoint(x: cell.bounds.origin.x, y: cell.bounds.origin.y)
            let cellLocation = cell.convert(cellCenter, to: collectionView)
            
            let xPosition = (CGFloat(indexPath.item) * (unFocussedCellWidth + 10)) - 50
            collectionView.collectionViewLayout.invalidateLayout()
            collectionView.setContentOffset(CGPoint(x: xPosition, y: 0), animated: true)
//            collectionView.collectionViewLayout.invalidateLayout()
        }
    }
}


extension ExpandingCarouselCellCollectionViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2000
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ExpandingCollectionViewCell", for: indexPath) as? ExpandingCollectionViewCell {
            cell.configureUI(index: indexPath.item)
            return cell
        }
        return UICollectionViewCell()
    }
}
extension ExpandingCarouselCellCollectionViewCell: UICollectionViewDelegate {
    
}
extension ExpandingCarouselCellCollectionViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if let lastFocussedIndexPath = lastFocussedIndexPath, lastFocussedIndexPath == indexPath {
            return CGSize(width: focussedCellWidth, height: cellHeight)
        }
        return CGSize(width: unFocussedCellWidth, height: cellHeight)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}

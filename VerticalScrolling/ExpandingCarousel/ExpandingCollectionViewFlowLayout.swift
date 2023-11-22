//
//  ExpandingCollectionViewFlowLayout.swift
//  VerticalScrolling
//
//  Created by saikiran panuganti on 21/11/23.
//

import UIKit

class ExpandingCollectionViewFlowLayout: UICollectionViewFlowLayout {
    var preferredPositionShouldX: CGFloat? = nil
    var preferredPositionDidX: CGFloat? = nil
    var cellWidth: CGFloat = 200
    var focussedCellWidth: CGFloat = 200
    var focussedIndex: Int?
    private var cache: [UICollectionViewLayoutAttributes] = []
    private var unFocussedCache: [UICollectionViewLayoutAttributes] = []
    private var contentWidth: CGFloat = 0
    private var contentHeight: CGFloat = 300
    
    var isFocussed: Bool = false {
        didSet {
            if oldValue != isFocussed {
                invalidateLayout()
            }
        }
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    override var flipsHorizontallyInOppositeLayoutDirection: Bool {
        return true
    }
    
    override func prepare() {
        super.prepare()
        
        guard let collectionView = collectionView else { return }
        let numberOfitems = collectionView.numberOfItems(inSection: 0)
        
        if !isFocussed {
            if numberOfitems == unFocussedCache.count {
                cache = unFocussedCache
                return
            }
            unFocussedCache.removeAll()
            cache.removeAll()
            let columnHeight = contentHeight
            
            var xOffset: CGFloat = 0
            
            for item in 0..<numberOfitems {
                let indexPath = IndexPath(item: item, section: 0)
                
                let width = cellWidth
                print("$$Expanding: unfocussed indexPath - \(indexPath), x - \(xOffset), width - \(width)")
                let frame = CGRect(x: xOffset, y: 0, width: width, height: columnHeight)
                let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                attributes.frame = frame
                cache.append(attributes)
                contentWidth = max(contentWidth, frame.maxX)
                xOffset = (xOffset + width + (DescInlineConstants.cellPadding))
            }
            unFocussedCache = cache
        }else {
            cache.removeAll()
            let columnHeight = contentHeight
            
            var xOffset: CGFloat = 0
            
            for item in 0..<numberOfitems {
                let indexPath = IndexPath(item: item, section: 0)
                
                var width = cellWidth
                if let focussedIndex = focussedIndex, focussedIndex == indexPath.item {
                    width = focussedCellWidth
                }
                print("$$Expanding: focussed indexPath - \(indexPath), focussedIndex - \(focussedIndex) x - \(xOffset), width - \(width)")
                let frame = CGRect(x: xOffset, y: 0, width: width, height: columnHeight)
                let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                attributes.frame = frame
                cache.append(attributes)
                contentWidth = max(contentWidth, frame.maxX)
                xOffset = (xOffset + width + (DescInlineConstants.cellPadding))
            }
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var visibleLayoutAttributes: [UICollectionViewLayoutAttributes] = []
        
        for attributes in cache {
            if attributes.frame.intersects(rect) {
                visibleLayoutAttributes.append(attributes)
            }
        }
        return visibleLayoutAttributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cache[indexPath.item]
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        if let expectedX = preferredPositionDidX ?? preferredPositionShouldX {
//            print("$$FULLSCREENDESCINLINE- targetContentOffset expectedX- \(expectedX)")
            return CGPoint(x: expectedX, y: proposedContentOffset.y)
        }else {
            let proposedRect = self.collectionView!.bounds
            if let layoutAttributesForElements = self.layoutAttributesForElements(in: proposedRect), layoutAttributesForElements.count > 0, let nearestOffsetX = getNearestX(layoutAttributes: layoutAttributesForElements, velocity: velocity, proposedOffSet: proposedContentOffset) {
//                print("$$FULLSCREENDESCINLINE- targetContentOffset nearestOffsetX- \(nearestOffsetX)")
                return CGPoint(x: nearestOffsetX, y: proposedContentOffset.y)
            }
        }
//        print("FULLSCREENDESCINLINE- targetContentOffset proposedContentOffset.x- \(proposedContentOffset.x)")
        return CGPoint(x: proposedContentOffset.x, y: proposedContentOffset.y)
    }
    
    func getNearestX(layoutAttributes: [UICollectionViewLayoutAttributes], velocity: CGPoint, proposedOffSet: CGPoint) -> CGFloat? {
        var result: (nearest: CGFloat, distance: CGFloat) = (proposedOffSet.x, .greatestFiniteMagnitude)
        
        for attribute in layoutAttributes {
            let distance = abs(attribute.frame.minX - proposedOffSet.x)
            if result.distance >= distance {
                result = (nearest: attribute.frame.minX, distance: distance)
            }
        }
        return result.nearest
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return false
    }
}

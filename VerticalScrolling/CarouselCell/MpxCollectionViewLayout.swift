//
//  MpxCollectionViewLayout.swift
//  VerticalScrolling
//
//  Created by Saikiran Panuganti on 06/10/23.
//

import UIKit

struct PromoCellProps {
    static var leftInset: CGFloat = 50
    static var cellPadding: CGFloat = 10
    static var featuredCellWidth: CGFloat = 990
}


class MpxCollectionViewLayout: UICollectionViewLayout {
    var preferredPositionShouldX: CGFloat? = nil
    var preferredPositionDidX: CGFloat? = nil
    
    var cellWidth: CGFloat = 300.0
    var featuredCellWidth: CGFloat = PromoCellProps.featuredCellWidth
    var xOffsetPrevious: CGFloat = -(PromoCellProps.leftInset)
    var multiplier: CGFloat = 0
    
    func getCurrentIndexNext(xOffset: CGFloat) -> Int {
        print("$$Promo: getCurrentIndex x - \((xOffset + PromoCellProps.leftInset)) cellWidth - \(cellWidth + PromoCellProps.cellPadding)")
        return Int((xOffset + PromoCellProps.leftInset)) / Int(cellWidth + PromoCellProps.cellPadding)
    }
    
    func getCurrentIndexPrevious(xOffset: CGFloat) -> Int {
        print("$$Promo: getCurrentIndex x - \((xOffset + PromoCellProps.leftInset)) cellWidth - \(cellWidth + PromoCellProps.cellPadding)")
        return Int(ceil((xOffset + PromoCellProps.leftInset) / (cellWidth + PromoCellProps.cellPadding)))
    }
    
    private let numberOfColumns = 1
    
    private var cache: [UICollectionViewLayoutAttributes] = []
    private var cacheBackUp: [UICollectionViewLayoutAttributes] = []
    
    private var contentWidth: CGFloat = 0
    private var contentHeight: CGFloat {
        guard let collectionView = collectionView else { return 0 }
        let insets = collectionView.contentInset
        return collectionView.bounds.height - (insets.top + insets.bottom)
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    override func prepare() {
        super.prepare()
        guard let collectionView = collectionView else { return }
        cache.removeAll()
        
        multiplier = (PromoCellProps.featuredCellWidth - cellWidth)/(cellWidth + PromoCellProps.cellPadding)
        let xOffSet_Coll = collectionView.contentOffset.x
        let columnHeight = contentHeight
        var xOffset: CGFloat = 0
        
        if xOffSet_Coll - xOffsetPrevious >= 0 {
            let currentIndex = getCurrentIndexNext(xOffset: xOffSet_Coll)
            let diff = xOffSet_Coll - (CGFloat(currentIndex)*(cellWidth + PromoCellProps.cellPadding)) + PromoCellProps.leftInset
            xOffsetPrevious = xOffSet_Coll
            if diff == 0 {
                for item in 0..<collectionView.numberOfItems(inSection: 0) {
                    let indexPath = IndexPath(item: item, section: 0)
                    
                    let width = (item == currentIndex) ? featuredCellWidth : cellWidth
                    let frame = CGRect(x: xOffset, y: 0, width: width, height: columnHeight)
                    let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                    attributes.frame = frame
                    cache.append(attributes)
                    contentWidth = max(contentWidth, frame.maxX)
                    xOffset = (xOffset + width + (PromoCellProps.cellPadding))
                }
            }else if diff > 0 {
                for item in 0..<collectionView.numberOfItems(inSection: 0) {
                    let indexPath = IndexPath(item: item, section: 0)
                    
                    var width = cellWidth
                    if item == currentIndex {
                        width = featuredCellWidth - diff*multiplier
                    }else if item == currentIndex + 1 {
                        width = cellWidth + diff*multiplier
                    }
                    
                    let frame = CGRect(x: xOffset, y: 0, width: width, height: columnHeight)
                    let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                    attributes.frame = frame
                    cache.append(attributes)
                    
                    contentWidth = max(contentWidth, frame.maxX)
                    xOffset = (xOffset + width + (PromoCellProps.cellPadding))
                }
            }
        }else {
            let currentIndex = getCurrentIndexPrevious(xOffset: xOffSet_Coll)
            let diff = xOffSet_Coll - (CGFloat(currentIndex)*(cellWidth + PromoCellProps.cellPadding)) + PromoCellProps.leftInset
            xOffsetPrevious = xOffSet_Coll
            if diff == 0 {
                for item in 0..<collectionView.numberOfItems(inSection: 0) {
                    let indexPath = IndexPath(item: item, section: 0)
                    let width = (item == currentIndex) ? featuredCellWidth : cellWidth
                    let frame = CGRect(x: xOffset, y: 0, width: width, height: columnHeight)
                    let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                    attributes.frame = frame
                    cache.append(attributes)
                    contentWidth = max(contentWidth, frame.maxX)
                    xOffset = (xOffset + width + (PromoCellProps.cellPadding))
                }
            }else if diff < 0 {
                for item in 0..<collectionView.numberOfItems(inSection: 0) {
                    let indexPath = IndexPath(item: item, section: 0)
                    
                    var width = cellWidth
                    if item == currentIndex {
//                        print("$$Promo: leftScroll indexPath - \(indexPath) featuredCellWidth - \(featuredCellWidth) diff - \(diff) width - \(featuredCellWidth + diff*2)")
                        width = featuredCellWidth + (diff*multiplier)
                    }else if item == currentIndex - 1 {
//                        print("$$Promo: leftScroll indexPath - \(indexPath) cellWidth - \(cellWidth) diff - \(diff) width - \(cellWidth - diff*2)")
                        width = cellWidth - (diff*multiplier)
                    }else {
                        width = cellWidth
                    }
                    let frame = CGRect(x: xOffset, y: 0, width: width, height: columnHeight)
                    let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                    attributes.frame = frame
                    cache.append(attributes)
                    
                    contentWidth = max(contentWidth, frame.maxX)
                    xOffset = (xOffset + width + (PromoCellProps.cellPadding))
                }
            }
        }
        
        cacheBackUp = cache
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
            return CGPoint(x: expectedX, y: proposedContentOffset.y)
        }else {
            let proposedRect = self.collectionView!.bounds
            if let layoutAttributesForElements = self.layoutAttributesForElements(in: proposedRect), layoutAttributesForElements.count > 0, let nearestOffsetX = getNearestX(layoutAttributes: layoutAttributesForElements, velocity: velocity, proposedOffSet: proposedContentOffset) {
                return CGPoint(x: nearestOffsetX, y: proposedContentOffset.y)
            }
        }
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
        return true
    }
}

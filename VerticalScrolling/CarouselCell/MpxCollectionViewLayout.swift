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
    static var cellWidth: CGFloat = 290
}


class MpxCollectionViewLayout: UICollectionViewLayout {
    var preferredPositionShouldX: CGFloat? = nil
    var preferredPositionDidX: CGFloat? = nil
    
    var isFocussed: Bool = false {
        didSet {
            if oldValue != isFocussed {
                invalidateLayout()
            }
        }
    }
    var hasPreparedLayout: Bool = false
    var cellWidth: CGFloat = 300.0
    var featuredCellWidth: CGFloat = PromoCellProps.featuredCellWidth
    var xOffsetPrevious: CGFloat = -(PromoCellProps.leftInset)
    var multiplier: CGFloat = 0
    
    func getCurrentIndexNext(xOffset: CGFloat) -> Int {
        return Int((xOffset + PromoCellProps.leftInset)) / Int(cellWidth + PromoCellProps.cellPadding)
    }
    
    func getCurrentIndexPrevious(xOffset: CGFloat) -> Int {
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
        var numberOfitems = collectionView.numberOfItems(inSection: 0)
        cache.removeAll()
        
        if !isFocussed {
            hasPreparedLayout = false
            let columnHeight = contentHeight
            var xOffset: CGFloat = 0
            
            for item in 0..<numberOfitems {
                let indexPath = IndexPath(item: item, section: 0)
                
                let width = cellWidth
                print("$$Layout: not focussed indexPath - \(indexPath)")
                let frame = CGRect(x: xOffset, y: 0, width: width, height: columnHeight)
                let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                attributes.frame = frame
                cache.append(attributes)
                contentWidth = max(contentWidth, frame.maxX)
                xOffset = (xOffset + width + (PromoCellProps.cellPadding))
            }
            print("$$Layout:::::::::::::::::::::::::::::::::END")
            return
        }
        multiplier = (PromoCellProps.featuredCellWidth - cellWidth)/(cellWidth + PromoCellProps.cellPadding)
        let xOffSet_Coll = collectionView.contentOffset.x
        let columnHeight = contentHeight
        var xOffset: CGFloat = 0
        print("$$Layout: lpstart multiplier - \(multiplier) xOffSet_Coll - \(xOffSet_Coll)")
        if xOffSet_Coll - xOffsetPrevious >= 0 {
            let currentIndex = getCurrentIndexNext(xOffset: xOffSet_Coll)
            let diff = xOffSet_Coll - (CGFloat(currentIndex)*(cellWidth + PromoCellProps.cellPadding)) + PromoCellProps.leftInset
            xOffsetPrevious = xOffSet_Coll
            print("$$Layout: lpstart greaterThanEqual diff - \(diff) currentIndex - \(currentIndex)")
            if diff == 0 {
                if cacheBackUp.count == numberOfitems && currentIndex + 1 < numberOfitems && hasPreparedLayout {
                    cache = cacheBackUp
                    if currentIndex > 0 {
                        xOffset = CGFloat(currentIndex - 1)*(cellWidth + PromoCellProps.cellPadding)
                    }
                    
                    for i in -1...1 {
                        let ind = currentIndex + i
                        if ind >= 0 {
                            let indexPath = IndexPath(item: ind, section: 0)
                            let width = (ind == currentIndex) ? featuredCellWidth : cellWidth
                            print("$$Layout: if>=0 prepared indexPath - \(indexPath) currentIndex - \(currentIndex) xOffset - \(xOffset) width - \(width)")
                            let frame = CGRect(x: xOffset, y: 0, width: width, height: columnHeight)
                            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                            attributes.frame = frame
                            cache[ind] = attributes   //.append(attributes)
                            contentWidth = max(contentWidth, cache.last?.frame.maxX ?? 0)
                            xOffset = (xOffset + width + (PromoCellProps.cellPadding))
                        }
                    }
                }else {
                    hasPreparedLayout = true
                    for item in 0..<numberOfitems {
                        let indexPath = IndexPath(item: item, section: 0)
                        
                        let width = (item == currentIndex) ? featuredCellWidth : cellWidth
                        print("$$Layout: if>=0 indexPath - \(indexPath) currentIndex - \(currentIndex) xOffset - \(xOffset) width - \(width)")
                        let frame = CGRect(x: xOffset, y: 0, width: width, height: columnHeight)
                        let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                        attributes.frame = frame
                        cache.append(attributes)
                        contentWidth = max(contentWidth, frame.maxX)
                        xOffset = (xOffset + width + (PromoCellProps.cellPadding))
                    }
                }
            }else if diff > 0 {
                if cacheBackUp.count == numberOfitems && currentIndex + 1 < numberOfitems && hasPreparedLayout {
                    cache = cacheBackUp
                    if currentIndex > 0 {
                        xOffset = CGFloat(currentIndex - 1)*(cellWidth + PromoCellProps.cellPadding)
                    }
                    for i in -1...1 {
                        let ind = currentIndex + i
                        if ind >= 0 {
                            let indexPath = IndexPath(item: ind, section: 0)
                            
                            var width = cellWidth
                            if ind == currentIndex {
                                width = featuredCellWidth - diff*multiplier
                            }else if ind == currentIndex + 1 {
                                width = cellWidth + diff*multiplier
                            }
                            print("$$Layout: if>=0else prepared indexPath - \(indexPath) currentIndex - \(currentIndex) xOffset - \(xOffset) width - \(width)")
                            let frame = CGRect(x: xOffset, y: 0, width: width, height: columnHeight)
                            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                            attributes.frame = frame
                            cache[ind] = attributes //.append(attributes)
                            
                            contentWidth = max(contentWidth, cache.last?.frame.maxX ?? 0)
                            xOffset = (xOffset + width + (PromoCellProps.cellPadding))
                        }
                    }
                }else {
                    hasPreparedLayout = true
                    for item in 0..<numberOfitems {
                        let indexPath = IndexPath(item: item, section: 0)
                        
                        var width = cellWidth
                        if item == currentIndex {
                            width = featuredCellWidth - diff*multiplier
                        }else if item == currentIndex + 1 {
                            width = cellWidth + diff*multiplier
                        }
                        print("$$Layout: if>=0else indexPath - \(indexPath) currentIndex - \(currentIndex) xOffset - \(xOffset) width - \(width)")
                        let frame = CGRect(x: xOffset, y: 0, width: width, height: columnHeight)
                        let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                        attributes.frame = frame
                        cache.append(attributes)
                        
                        contentWidth = max(contentWidth, frame.maxX)
                        xOffset = (xOffset + width + (PromoCellProps.cellPadding))
                    }
                }
            }
        }else {
            let currentIndex = getCurrentIndexPrevious(xOffset: xOffSet_Coll)
            let diff = xOffSet_Coll - (CGFloat(currentIndex)*(cellWidth + PromoCellProps.cellPadding)) + PromoCellProps.leftInset
            xOffsetPrevious = xOffSet_Coll
            print("$$Layout: lpstart lessThan diff - \(diff) currentIndex - \(currentIndex)")
            if diff == 0 {
                if cacheBackUp.count == numberOfitems && currentIndex + 1 < numberOfitems && hasPreparedLayout {
                    cache = cacheBackUp
                    if currentIndex > 0 {
                        xOffset = CGFloat(currentIndex - 1)*(cellWidth + PromoCellProps.cellPadding)
                    }
                    for i in -1...1 {
                        let ind = currentIndex + i
                        if ind >= 0 {
                            let indexPath = IndexPath(item: ind, section: 0)
                            let width = (ind == currentIndex) ? featuredCellWidth : cellWidth
                            print("$$Layout: else prepared indexPath - \(indexPath) currentIndex - \(currentIndex) xOffset - \(xOffset) width - \(width)")
                            let frame = CGRect(x: xOffset, y: 0, width: width, height: columnHeight)
                            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                            attributes.frame = frame
                            cache[ind] = attributes //.append(attributes)
                            contentWidth = max(contentWidth, cache.last?.frame.maxX ?? 0)
                            xOffset = (xOffset + width + (PromoCellProps.cellPadding))
                        }
                    }
                }else {
                    hasPreparedLayout = true
                    for item in 0..<numberOfitems {
                        let indexPath = IndexPath(item: item, section: 0)
                        let width = (item == currentIndex) ? featuredCellWidth : cellWidth
                        print("$$Layout: else indexPath - \(indexPath) currentIndex - \(currentIndex) xOffset - \(xOffset) width - \(width)")
                        let frame = CGRect(x: xOffset, y: 0, width: width, height: columnHeight)
                        let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                        attributes.frame = frame
                        cache.append(attributes)
                        contentWidth = max(contentWidth, frame.maxX)
                        xOffset = (xOffset + width + (PromoCellProps.cellPadding))
                    }
                }
            }else if diff < 0 {
                if cacheBackUp.count == numberOfitems && currentIndex + 1 < numberOfitems && hasPreparedLayout {
                    cache = cacheBackUp
                    if currentIndex > 0 {
                        xOffset = CGFloat(currentIndex - 1)*(cellWidth + PromoCellProps.cellPadding)
                    }
                    for i in -1...1 {
                        let ind = currentIndex + i
                        if ind >= 0 {
                            let indexPath = IndexPath(item: ind, section: 0)
                            
                            var width = cellWidth
                            if ind == currentIndex {
                                width = featuredCellWidth + (diff*multiplier)
                            }else if ind == currentIndex - 1 {
                                width = cellWidth - (diff*multiplier)
                            }else {
                                width = cellWidth
                            }
                            print("$$Layout: elseelse prepared indexPath - \(indexPath) currentIndex - \(currentIndex) \(currentIndex - 1) xOffset - \(xOffset) width - \(width)")
                            let frame = CGRect(x: xOffset, y: 0, width: width, height: columnHeight)
                            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                            attributes.frame = frame
                            cache[ind] = attributes //.append(attributes)
                            contentWidth = max(contentWidth, frame.maxX)
                            xOffset = (xOffset + width + (PromoCellProps.cellPadding))
                        }
                    }
                }else {
                    hasPreparedLayout = true
                    for item in 0..<numberOfitems {
                        let indexPath = IndexPath(item: item, section: 0)
                        
                        var width = cellWidth
                        if item == currentIndex {
                            width = featuredCellWidth + (diff*multiplier)
                        }else if item == currentIndex - 1 {
                            width = cellWidth - (diff*multiplier)
                        }else {
                            width = cellWidth
                        }
                        print("$$Layout: elseelse indexPath - \(indexPath) currentIndex - \(currentIndex) \(currentIndex - 1) xOffset - \(xOffset) width - \(width)")
                        let frame = CGRect(x: xOffset, y: 0, width: width, height: columnHeight)
                        let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                        attributes.frame = frame
                        cache.append(attributes)
                        contentWidth = max(contentWidth, frame.maxX)
                        xOffset = (xOffset + width + (PromoCellProps.cellPadding))
                    }
                }
            }
        }
        
        cacheBackUp = cache
        print("$$Layout:::::::::::::::::::::::::::::::::END")
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

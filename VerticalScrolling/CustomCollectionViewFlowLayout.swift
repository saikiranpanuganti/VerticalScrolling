//
//  CustomCollectionViewFlowLayout.swift
//  VerticalScrolling
//
//  Created by SaiKiran Panuganti on 22/09/23.
//

import UIKit


class CustomHorizontalCollectionViewFlowLayout: UICollectionViewFlowLayout {
    var preferredPositionShouldX: CGFloat? = nil
    var preferredPositionDidX: CGFloat? = nil
    var cellSize: CGSize = CGSize(width: 300, height: 300)
    
    override func prepare() {
        super.prepare()
        
        guard let collectionView = collectionView else { return }
        
        self.itemSize = cellSize
        self.sectionInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        self.sectionInsetReference = .fromSafeArea
        self.scrollDirection = .horizontal
        self.minimumLineSpacing = 20
        self.minimumInteritemSpacing = 20
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        print("targetContentOffset X Horizontal cellSize - \(cellSize)")
        if let expectedX = preferredPositionDidX ?? preferredPositionShouldX {
//            AppData.shared.preferredPositionDidX = nil
//            AppData.shared.preferredPositionShouldX = nil
            print("Final expectedX Horizontal - \(expectedX)")
            return CGPoint(x: expectedX, y: proposedContentOffset.y)
        }else {
            let proposedRect = self.collectionView!.bounds
            print("proposedContentOffset Horizontal - \(proposedContentOffset)")
            print("velocity Horizontal - \(velocity)")
            print("layoutAtributes Horizontal - \(self.layoutAttributesForElements(in: proposedRect))")
            if let layoutAttributesForElements = self.layoutAttributesForElements(in: proposedRect), layoutAttributesForElements.count > 0, let nearestOffsetX = getNearestX(layoutAttributes: layoutAttributesForElements, velocity: velocity, proposedOffSet: proposedContentOffset) {
                print("Final nearestOffsetX Horizontal - \(nearestOffsetX)")
                return CGPoint(x: nearestOffsetX, y: proposedContentOffset.y)
            }
        }
        print("Final proposedContentOffsetX Horizontal - \(proposedContentOffset.x)")
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
}





class CustomVerticalCollectionViewFlowLayout: UICollectionViewFlowLayout {
    var preferredPositionDidY: CGFloat?
    var preferredPositionShouldY: CGFloat?
    private var isFastScrolling: Bool = false
    var focusUpdated: Bool = false
    
    override func prepare() {
        super.prepare()
        
        guard let collectionView = collectionView else { return }
        
        self.itemSize = CGSize(width: collectionView.frame.width, height: 400)
        self.sectionInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        self.sectionInsetReference = .fromSafeArea
        self.scrollDirection = .vertical
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        print("targetContentOffset Y Vertical velocity - \(velocity.y)")
        if velocity.y > 8 || velocity.y < -8 {
            isFastScrolling = true
            focusUpdated = false
        }
        
        if isFastScrolling && !focusUpdated {
            return proposedContentOffset
        }
        
        if let expectedY = preferredPositionDidY ?? preferredPositionShouldY {
//            AppData.shared.preferredPositionDidY = nil
//            AppData.shared.preferredPositionShouldY = nil
            print("Final expectedY Vertical - \(expectedY)")
            return CGPoint(x: proposedContentOffset.x, y: expectedY)
        }else {
            let proposedRect = self.collectionView!.bounds
            print("proposedContentOffset Vertical - \(proposedContentOffset)")
            print("velocity Vertical - \(velocity)")
            print("layoutAtributes Vertical - \(self.layoutAttributesForElements(in: proposedRect))")
            if let layoutAttributesForElements = self.layoutAttributesForElements(in: proposedRect), layoutAttributesForElements.count > 0, let nearestY = getNearestY(layoutAttributes: layoutAttributesForElements, velocity: velocity, proposedOffSet: proposedContentOffset) {
                print("Final nearestOffsetY Vertical - \(nearestY)")
                return CGPoint(x: proposedContentOffset.y, y: nearestY)
            }
        }
        print("Final proposedContentOffsetY Vertical - \(proposedContentOffset.y)")
        return CGPoint(x: proposedContentOffset.x, y: proposedContentOffset.y)
    }
    
    func getNearestY(layoutAttributes: [UICollectionViewLayoutAttributes], velocity: CGPoint, proposedOffSet: CGPoint) -> CGFloat? {
        var result: (nearest: CGFloat, distance: CGFloat) = (proposedOffSet.y, .greatestFiniteMagnitude)
        
        for attribute in layoutAttributes {
            let distance = abs(attribute.frame.minY - proposedOffSet.y)
            if result.distance >= distance {
                result = (nearest: attribute.frame.minY, distance: distance)
            }
        }
        return result.nearest
    }
}























class CustomCollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {

//                    let rectBounds:CGRect = self.collectionView!.bounds
//                    let halfHeight:CGFloat = rectBounds.size.height * CGFloat(0.45)
//                    let proposedContentOffsetCenterY:CGFloat = proposedContentOffset.y + halfHeight
//        //
//                let attributesArray:NSArray = self.layoutAttributesForElements(in: rectBounds)! as NSArray
//        //
//                    var candidateAttributes:UICollectionViewLayoutAttributes?
//        //
//                    for layoutAttributes in attributesArray {
//                        print("layoutAttributes - \(layoutAttributes)")
//                        if let _layoutAttributes = layoutAttributes as? UICollectionViewLayoutAttributes {
//
//                            if _layoutAttributes.representedElementCategory != UICollectionView.ElementCategory.cell {
//                                continue
//                            }
//
//                            if candidateAttributes == nil {
//                                candidateAttributes = _layoutAttributes
//                                continue
//                            }
//
//                            if fabsf(Float(_layoutAttributes.center.y) - Float(proposedContentOffsetCenterY)) < fabsf(Float(candidateAttributes!.center.y) - Float(proposedContentOffsetCenterY)) {
//                                candidateAttributes = _layoutAttributes
//                            }
//                        }
//                    }
        //
        //            if attributesArray.count == 0 {
        //                return CGPointMake(proposedContentOffset.x,proposedContentOffset.y)
        //            }
        //
        //        return CGPointMake(proposedContentOffset.x,candidateAttributes!.frame.minY)
//
//                    print("candidateAttributes - \(candidateAttributes)")
//
//                    print("proposedContentOffset - \(proposedContentOffset)")
//                    return proposedContentOffset
//
//
//                guard let collectionView = collectionView else {
//                    return proposedContentOffset
//                }


        let collectionViewSize = self.collectionView!.bounds.size
        let proposedContentOffsetCenterY = proposedContentOffset.y + collectionViewSize.height * 0.5

        var proposedRect = self.collectionView!.bounds

        proposedRect = CGRect(x: 0, y: proposedContentOffset.y, width: collectionViewSize.width, height: collectionViewSize.height)

        var candidateAttributes: UICollectionViewLayoutAttributes?
        print("proposedContentOffset - \(proposedContentOffset) velocity - \(velocity)")
        print("layoutAttributes - \(self.layoutAttributesForElements(in: proposedRect))")
        for attributes in self.layoutAttributesForElements(in: proposedRect)! {
            print("")
            // == Skip comparison with non-cell items (headers and footers) == //
            if attributes.representedElementCategory != .cell {
                continue
            }

            // Get collectionView current scroll position
            let currentOffset = self.collectionView!.contentOffset

            if (attributes.center.y <= (currentOffset.y + collectionViewSize.height * 0.5) && velocity.y > 0) || (attributes.center.y >= (currentOffset.y + collectionViewSize.height * 0.5) && velocity.y < 0) {

                continue
            }

            // First good item in the loop
            if candidateAttributes == nil {
                candidateAttributes = attributes
                continue
            }

            // Save constants to improve readability
            let lastCenterOffset = candidateAttributes!.center.y - proposedContentOffsetCenterY
            let centerOffset = attributes.center.y - proposedContentOffsetCenterY

            if fabsf( Float(centerOffset) ) < fabsf( Float(lastCenterOffset) ) {
                candidateAttributes = attributes
            }
        }
        print("candidateAttributes - \(candidateAttributes)")
//        return CGPoint(x: proposedContentOffset.x, y: candidateAttributes?.frame.minY ?? proposedContentOffset.y)
        return CGPoint(x: proposedContentOffset.x, y: proposedContentOffset.y)
    }

//    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
//            let attributes = super.layoutAttributesForElements(in: rect)
//
//            var topMargin = sectionInset.top
//            var maxX: CGFloat = -1.0
//            attributes?.forEach { layoutAttribute in
//                if layoutAttribute.frame.origin.x >= maxX {
//                    topMargin = sectionInset.top
//                }
//
//                layoutAttribute.frame.origin.y = topMargin
//
//                topMargin += layoutAttribute.frame.height + minimumInteritemSpacing
//                maxX = max(layoutAttribute.frame.maxX , maxX)
//            }
//
//            return attributes
//        }
}

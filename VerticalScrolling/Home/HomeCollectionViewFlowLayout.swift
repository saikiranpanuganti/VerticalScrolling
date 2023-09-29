//
//  HomeCollectionViewFlowLayout.swift
//  VerticalScrolling
//
//  Created by Saikiran Panuganti on 29/09/23.
//

import UIKit


class HomeCollectionViewFlowLayout: UICollectionViewFlowLayout {
    var preferredPositionDidY: CGFloat?
    var preferredPositionShouldY: CGFloat?
    private var isFastScrolling: Bool = false
    var focusUpdated: Bool = false
    var cellSize: CGSize = CGSize(width: 1650, height: 400)
    
    override func prepare() {
        super.prepare()
        
        guard let collectionView = collectionView else { return }
        
        self.itemSize = cellSize
        self.sectionInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        self.sectionInsetReference = .fromContentInset
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

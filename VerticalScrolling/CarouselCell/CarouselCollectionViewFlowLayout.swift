//
//  CarouselCollectionViewFlowLayout.swift
//  VerticalScrolling
//
//  Created by Saikiran Panuganti on 29/09/23.
//

import UIKit

class CarouselCollectionViewFlowLayout: UICollectionViewFlowLayout {
    var preferredPositionShouldX: CGFloat? = nil
    var preferredPositionDidX: CGFloat? = nil
    var cellSize: CGSize = CGSize(width: 300, height: 300)
    
    override func prepare() {
        super.prepare()
        
        guard let collectionView = collectionView else { return }
        
        self.itemSize = cellSize
        self.sectionInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        self.sectionInsetReference = .fromContentInset
        self.scrollDirection = .horizontal
        self.minimumLineSpacing = 20
        self.minimumInteritemSpacing = 0
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

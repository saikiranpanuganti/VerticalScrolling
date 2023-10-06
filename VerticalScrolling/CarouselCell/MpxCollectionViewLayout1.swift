//
//  MpxCollectionViewLayout1.swift
//  VerticalScrolling
//
//  Created by Saikiran Panuganti on 06/10/23.
//

import UIKit

// The heights are declared as constants outside of the class so they can be easily referenced elsewhere
struct UltravisualLayoutConstants {
  struct Cell {
    // The height of the non-featured cell
    static let standardWidth: CGFloat = 300
    // The height of the first visible cell
    static let featuredWidth: CGFloat = 500
  }
}

// MARK: Properties and Variables

class MpxCollectionViewLayout1: UICollectionViewLayout {
    var preferredPositionShouldX: CGFloat? = nil
    var preferredPositionDidX: CGFloat? = nil
  // The amount the user needs to scroll before the featured cell changes
  let dragOffset: CGFloat = 200.0
  
  var cache: [UICollectionViewLayoutAttributes] = []
  
  // Returns the item index of the currently featured cell
  var featuredItemIndex: Int {
    // Use max to make sure the featureItemIndex is never < 0
    return max(Int(collectionView!.contentOffset.x / dragOffset), 0)
  }
  
  // Returns a value between 0 and 1 that represents how close the next cell is to becoming the featured cell
  var nextItemPercentageOffset: CGFloat {
    return (collectionView!.contentOffset.x / dragOffset) - CGFloat(featuredItemIndex)
  }
  
  // Returns the width of the collection view
  var width: CGFloat {
    return collectionView!.bounds.width
  }
  
  // Returns the height of the collection view
  var height: CGFloat {
    return collectionView!.bounds.height
  }
  
  // Returns the number of items in the collection view
  var numberOfItems: Int {
    return collectionView!.numberOfItems(inSection: 0)
  }
}

// MARK: UICollectionViewLayout

extension MpxCollectionViewLayout1 {
  // Return the size of all the content in the collection view
  override var collectionViewContentSize : CGSize {
    let contentWidth = (CGFloat(numberOfItems) * dragOffset) + (width - dragOffset)
    return CGSize(width: contentWidth, height: height)
  }
  
  override func prepare() {
    cache.removeAll(keepingCapacity: false)
    
    let standardWidth = UltravisualLayoutConstants.Cell.standardWidth
    let featuredWidth = UltravisualLayoutConstants.Cell.featuredWidth
  
    var frame = CGRect.zero
    var x: CGFloat = 0
    
    for item in 0..<numberOfItems {
      let indexPath = IndexPath(item: item, section: 0)
      let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
      // Important because each cell has to slide over the top of the previous one
      attributes.zIndex = item
      // Initially set the height of the cell to the standard height
      var width = standardWidth
      if indexPath.item == featuredItemIndex {
        // The featured cell
        let xOffset = standardWidth * nextItemPercentageOffset
        x = collectionView!.contentOffset.x - xOffset
        width = featuredWidth
      } else if indexPath.item == (featuredItemIndex + 1) && indexPath.item != numberOfItems {
        // The cell directly below the featured cell, which grows as the user scrolls
        let maxX = x + standardWidth
        width = standardWidth + max((featuredWidth - standardWidth) * nextItemPercentageOffset, 0)
        x = maxX - width
      }
      frame = CGRect(x: x, y: 0, width: width, height: height)
      attributes.frame = frame
      cache.append(attributes)
      x = frame.maxX + 20
    }
    print("Cache: \(cache.count)")
  }
  
  // Return all attributes in the cache whose frame intersects with the rect passed to the method
  override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
    var layoutAttributes: [UICollectionViewLayoutAttributes] = []
    for attributes in cache {
      if attributes.frame.intersects(rect) {
        layoutAttributes.append(attributes)
      }
    }
    return layoutAttributes
  }
  
  // Return the content offset of the nearest cell which achieves the nice snapping effect, similar to a paged UIScrollView
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
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
  
  // Return true so that the layout is continuously invalidated as the user scrolls
  override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
    return true
  }
}

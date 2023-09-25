//
//  ViewController.swift
//  VerticalScrolling
//
//  Created by SaiKiran Panuganti on 22/09/23.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(UINib(nibName: "ImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ImageCollectionViewCell")
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
//    func collectionView(_ collectionView: UICollectionView, shouldUpdateFocusIn context: UICollectionViewFocusUpdateContext) -> Bool {
//        if let indexPath = context.nextFocusedIndexPath, let cell = collectionView.cellForItem(at: indexPath) {
//            let cellCenter = CGPoint(x: cell.bounds.origin.x, y: cell.bounds.origin.y)
//            let cellLocation = cell.convert(cellCenter, to: collectionView)
//            AppData.shared.preferredPositionShould = cellLocation.y
//            print("$$VerticalScrolling: shouldUpdateFocusIn y - \(cellLocation.y) || ySet - \(cellLocation.y-492) ms - \(Date().timeIntervalSince1970*1000)")
//        }
//        return true
//    }
//
//    func collectionView(_ collectionView: UICollectionView, didUpdateFocusIn context: UICollectionViewFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
//        if let indexPath = context.nextFocusedIndexPath, let cell = collectionView.cellForItem(at: indexPath) {
//            let cellCenter = CGPoint(x: cell.bounds.origin.x, y: cell.bounds.origin.y)
//            let cellLocation = cell.convert(cellCenter, to: collectionView)
//            AppData.shared.preferredPositionDid = cellLocation.y
//            print("$$VerticalScrolling: didUpdateFocusIn - \(cellLocation.y) || ySet - \(cellLocation.y-492) ms - \(Date().timeIntervalSince1970*1000)")
//        }
//    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 300
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell", for: indexPath) as? ImageCollectionViewCell {
            cell.configureUI(index: indexPath.item)
            
            return cell
        }
        return UICollectionViewCell()
    }
}
extension ViewController: UICollectionViewDelegate {
    
}
extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.item % 7 == 0 {
            return CGSize(width: 200, height: 300)
        }
        return CGSize(width: 200, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 50
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 50
    }
}




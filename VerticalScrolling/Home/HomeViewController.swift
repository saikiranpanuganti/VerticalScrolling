//
//  HomeViewController.swift
//  VerticalScrolling
//
//  Created by SaiKiran Panuganti on 29/09/23.
//

import UIKit


class HomeViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(UINib(nibName: "CarouselCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CarouselCollectionViewCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        configureCollectionView()
    }
    
    func configureCollectionView() {
        if let collectionViewLayout = collectionView.collectionViewLayout as? HomeCollectionViewFlowLayout {
            print("self.view.frame.width - \(self.view.frame.width)")
            collectionViewLayout.cellSize = CGSize(width: self.view.frame.width-250, height: 400)
        }
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, canFocusItemAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldUpdateFocusIn context: UICollectionViewFocusUpdateContext) -> Bool {
        if let indexPath = context.nextFocusedIndexPath, let cell = collectionView.cellForItem(at: indexPath) {
            let cellCenter = CGPoint(x: cell.bounds.origin.x, y: cell.bounds.origin.y)
            let cellLocation = cell.convert(cellCenter, to: collectionView)
//            AppData.shared.preferredPositionShouldY = cellLocation.y
            if let collectionViewLayout = collectionView.collectionViewLayout as? HomeCollectionViewFlowLayout {
                collectionViewLayout.preferredPositionShouldY = cellLocation.y
            }
            print("$$HomeCollectionViewFlowLayout Controller: shouldUpdateFocusIn y - \(cellLocation.y) ms - \(Date().timeIntervalSince1970*1000)")
        }
        return true
    }

    func collectionView(_ collectionView: UICollectionView, didUpdateFocusIn context: UICollectionViewFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        if let indexPath = context.nextFocusedIndexPath, let cell = collectionView.cellForItem(at: indexPath) {
            let cellCenter = CGPoint(x: cell.bounds.origin.x, y: cell.bounds.origin.y)
            let cellLocation = cell.convert(cellCenter, to: collectionView)
//            AppData.shared.preferredPositionDidY = cellLocation.y
            print("$$HomeCollectionViewFlowLayout Controller: didUpdateFocusIn - \(cellLocation.y) ms - \(Date().timeIntervalSince1970*1000)")
            if let collectionViewLayout = collectionView.collectionViewLayout as? HomeCollectionViewFlowLayout {
                collectionViewLayout.preferredPositionDidY = cellLocation.y
                collectionViewLayout.focusUpdated = true
            }
        }
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 300
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CarouselCollectionViewCell", for: indexPath) as? CarouselCollectionViewCell {
            cell.configureUI(index: indexPath.item)
            
            return cell
        }
        return UICollectionViewCell()
    }
}

extension HomeViewController: UICollectionViewDelegate {
    
}

//extension ViewControllerGesture: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        if indexPath.item % 7 == 0 {
//            return CGSize(width: 300, height: 300)
//        }
//        return CGSize(width: 200, height: 300)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 50
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 50
//    }
//}




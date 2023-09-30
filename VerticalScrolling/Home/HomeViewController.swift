//
//  HomeViewController.swift
//  VerticalScrolling
//
//  Created by SaiKiran Panuganti on 29/09/23.
//

import UIKit


class HomeViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var heights: [CGFloat] = [400, 500, 300, 400, 500, 400, 400, 500, 600, 400, 500, 300, 400, 500, 400, 400, 500, 600, 400, 500, 300, 400, 500, 400, 400, 500, 600, 400, 300, 300, 300, 500, 400, 400, 500, 600, 400, 500, 300, 400, 500, 400, 400, 500, 600, 400, 500, 300, 400, 500, 400, 400, 500, 600, 400, 500, 300, 400, 500, 400, 400, 500, 600, 400, 500, 300, 400, 500, 400, 400, 500, 600, 400, 500, 300, 400, 500, 400, 400, 500, 600, 400, 500, 300, 400, 500, 400, 400, 500, 600, 400, 500, 300, 400, 500, 400, 400, 500, 600, 400, 500, 300, 400, 500, 400, 400, 500, 600, 400, 500, 300, 400, 500, 400, 400, 500, 600, 400, 500, 300, 400, 500, 400, 400, 500, 600, 400, 500, 300, 400, 500, 400, 400, 500, 600, 400, 500, 300, 400, 500, 400, 400, 500, 600, 400, 500, 300, 400, 500, 400, 400, 500, 600, 400, 500, 300, 400, 500, 400, 400, 500, 600, 400, 500, 300, 400, 500, 400, 400, 500, 600, 400, 500, 300, 400, 500, 400, 400, 500, 600, 400, 500, 300, 400, 500, 400, 400, 500, 600, 400, 500, 300, 400, 500, 400, 400, 500, 600, 400, 500, 300, 400, 500, 400, 400, 500, 600, 400, 500, 300, 400, 500, 400, 400, 500, 600, 400, 500, 300, 400, 500, 400, 400, 500, 600, 400, 500, 300, 400, 500, 400, 400, 500, 600, 400, 500, 300, 400, 500, 400, 400, 500, 600, 400, 500, 300, 400, 500, 400, 400, 500, 600, 400, 500, 300, 400, 500, 400, 400, 500, 600, 400, 500, 300, 400, 500, 400, 400, 500, 600, 400, 500, 300, 400, 500, 400, 400, 500, 600, 400, 500, 300, 400, 500, 400, 400, 500, 600, 400, 500, 300, 400, 500, 400, 400, 500, 600, 400, 500, 300, 400, 500, 400, 400, 500, 600, 400, 500, 300, 400, 500, 400, 400, 500, 600, 400, 500, 300, 400, 500, 400, 400, 500, 600, 400, 500, 300, 400, 500, 400, 400, 500, 600, 400, 500, 300, 400, 500, 400, 400, 500, 600, 400, 500, 300, 400, 500, 400, 400, 500, 600, 400, 500, 300, 400, 500, 400, 400, 500, 600, 400, 500, 300, 400, 500, 400, 400, 500, 600, 400, 500, 300, 400, 500, 400, 400, 500, 600]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(UINib(nibName: "CarouselCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CarouselCollectionViewCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        configureCollectionView()
    }
    
    func configureCollectionView() {
        if let layout = collectionView?.collectionViewLayout as? HomeCollectionViewFlowLayout {
          layout.delegate = self
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

extension HomeViewController: HomeCollectionViewFlowLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForItemAtIndexPath indexPath:IndexPath) -> CGFloat {
        return heights[indexPath.item]
    }
}




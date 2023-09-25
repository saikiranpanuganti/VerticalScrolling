//
//  ImageCollectionViewCell.swift
//  VerticalScrolling
//
//  Created by SaiKiran Panuganti on 22/09/23.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var numberLabel: UILabel!
    
    
    func configureUI(index: Int) {
        numberLabel.text = "\(index)"
        self.layer.borderColor = UIColor.orange.cgColor
        self.layer.borderWidth = 0
    }
    
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        if let cell = context.previouslyFocusedView as? ImageCollectionViewCell {
//            UIView.animate(withDuration: 0.3) {
//                cell.transform = .identity
//            }
            cell.layer.borderWidth = 0
        }
        
        if let cell = context.nextFocusedView as? ImageCollectionViewCell {
//            UIView.animate(withDuration: 0.3) {
//                cell.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
//            }
            cell.layer.borderWidth = 5.0
        }
    }
}

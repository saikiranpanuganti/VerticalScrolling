//
//  PromoImageCollectionViewCell.swift
//  VerticalScrolling
//
//  Created by Saikiran Panuganti on 07/10/23.
//

import UIKit

class PromoImageCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var numberLabel: UILabel!
    
    func configureUI(index: Int) {
        numberLabel.text = "\(index)"
        numberLabel.layer.borderColor = UIColor.orange.cgColor
        numberLabel.layer.borderWidth = 0
    }
    
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        if let cell = context.previouslyFocusedView as? PromoImageCollectionViewCell {
            cell.numberLabel.layer.borderWidth = 0
        }
        
        if let cell = context.nextFocusedView as? PromoImageCollectionViewCell {
            cell.numberLabel.layer.borderWidth = 5.0
        }
    }
}

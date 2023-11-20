//
//  ExpandingCollectionViewCell.swift
//  VerticalScrolling
//
//  Created by saikiran panuganti on 21/11/23.
//

import UIKit

class ExpandingCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageOutlet: UIImageView!
    @IBOutlet weak var numberLabel: UILabel!
    
    func configureUI(index: Int) {
        if index%2 == 0 {
            imageOutlet.backgroundColor = UIColor.systemMint
        }else {
            imageOutlet.backgroundColor = UIColor.systemTeal
        }
        numberLabel.text = "\(index)"
        imageOutlet.layer.borderColor = UIColor.orange.cgColor
        imageOutlet.layer.borderWidth = 0
    }
    
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        if context.previouslyFocusedView == self {
            imageOutlet.layer.borderWidth = 0
        }
        
        if context.nextFocusedView == self {
            imageOutlet.layer.borderWidth = 5
        }
    }
}

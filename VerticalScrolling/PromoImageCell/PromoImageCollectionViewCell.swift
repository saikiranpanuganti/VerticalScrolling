//
//  PromoImageCollectionViewCell.swift
//  VerticalScrolling
//
//  Created by Saikiran Panuganti on 07/10/23.
//

import UIKit

protocol PromoImageCollectionViewCellDelegate: AnyObject {
    func cellFocussed()
    func cellUnFocussed()
}

class PromoImageCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var metaDataView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var providersLabel: UILabel!
    
    weak var delegate: PromoImageCollectionViewCellDelegate?
    
    func configureUI(index: Int) {
        numberLabel.text = "\(index)"
        metaDataView.alpha = 0
    }
    
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        if let _ = context.previouslyFocusedView as? PromoImageCollectionViewCell {
            delegate?.cellUnFocussed()
        }
        
        if let _ = context.nextFocusedView as? PromoImageCollectionViewCell {
            delegate?.cellFocussed()
        }
    }
}

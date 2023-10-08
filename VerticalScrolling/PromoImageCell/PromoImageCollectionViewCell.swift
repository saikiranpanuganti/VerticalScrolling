//
//  PromoImageCollectionViewCell.swift
//  VerticalScrolling
//
//  Created by Saikiran Panuganti on 07/10/23.
//

import UIKit

class PromoImageCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var metaDataView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var providersLabel: UILabel!
    
    func configureUI(index: Int) {
        numberLabel.text = "\(index)"
        numberLabel.layer.borderColor = UIColor.orange.cgColor
        numberLabel.layer.borderWidth = 0
        metaDataView.alpha = 0
    }
    
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        if let cell = context.previouslyFocusedView as? PromoImageCollectionViewCell {
            cell.numberLabel.layer.borderWidth = 0
            cell.metaDataView.alpha = 0
        }
        
        if let cell = context.nextFocusedView as? PromoImageCollectionViewCell {
            UIView.animate(withDuration: 2) {
                cell.numberLabel.layer.borderWidth = 5.0
                cell.metaDataView.alpha = 1
            }
        }
    }
}

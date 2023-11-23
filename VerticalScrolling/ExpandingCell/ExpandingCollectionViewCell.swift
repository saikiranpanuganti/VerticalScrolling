//
//  ExpandingCollectionViewCell.swift
//  VerticalScrolling
//
//  Created by saikiran panuganti on 21/11/23.
//

import UIKit

protocol ExpandingCollectionViewCellDelegate: AnyObject {
    func expandingCellFocussed()
    func expandingCellUnFocussed()
}

class ExpandingCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageOutlet: UIImageView!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var cellBackgroundView: UIView!
    @IBOutlet weak var imageBackgroundView: UIView!
    @IBOutlet weak var bgImage: UIImageView!
    @IBOutlet weak var imageBgViewHeight: NSLayoutConstraint!
    @IBOutlet weak var imageBgViewLeft: NSLayoutConstraint!
    @IBOutlet weak var imageBgViewBottom: NSLayoutConstraint!
    
    var defaultImageHeight: CGFloat = AppConstants.expandingCellHeight
    var focussedImageHeight: CGFloat = AppConstants.expandingCellHeight*0.53
    
    weak var delegate: ExpandingCollectionViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imageBgViewHeight.constant = AppConstants.expandingCellHeight
    }
    
    func configureUI(index: Int) {
        if index%2 == 0 {
            imageOutlet.backgroundColor = UIColor.systemMint
        }else {
            imageOutlet.backgroundColor = UIColor.systemTeal
        }
        numberLabel.text = "\(index)"
        cellBackgroundView.layer.borderColor = UIColor.orange.cgColor
        cellBackgroundView.layer.borderWidth = 0
    }
    
    func animateImageView() {
        UIView.animate(withDuration: 0.5) { [weak self] in
            guard let strongSelf = self else { return }
            
            strongSelf.imageBgViewHeight.constant = strongSelf.focussedImageHeight
            strongSelf.imageBgViewLeft.constant = 36
            strongSelf.imageBgViewBottom.constant = 36
            strongSelf.layoutIfNeeded()
        }
    }
    
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        if context.previouslyFocusedView == self {
            imageBgViewHeight.constant = defaultImageHeight
            imageBgViewLeft.constant = 0
            imageBgViewBottom.constant = 0
            cellBackgroundView.layer.borderWidth = 0
            delegate?.expandingCellUnFocussed()
        }
        
        if context.nextFocusedView == self {
            cellBackgroundView.layer.borderWidth = 5
            delegate?.expandingCellFocussed()
        }
    }
}

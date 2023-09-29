//
//  MenuTableViewCell.swift
//  VerticalScrolling
//
//  Created by SaiKiran Panuganti on 29/09/23.
//

import UIKit

class MenuTableViewCell: UITableViewCell {
    @IBOutlet weak var menuIcon: UIImageView!
    @IBOutlet weak var menuTitle: UILabel!
    @IBOutlet weak var focussedView: UIView!
    
    var menu: Menu?

    override func awakeFromNib() {
        super.awakeFromNib()
        
        focussedView.isHidden = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        focussedView.isHidden = true
    }
    
    func configureUI(menu: Menu) {
        self.menu = menu
        menuIcon.image = UIImage(systemName: menu.unSelectedIcon)
        menuTitle.text = menu.titleName
        if menu.isSelected {
            setSelectedState()
        }else {
            setUnSelectedState()
        }
    }

    func setFocussedState() {
        focussedView.isHidden = false
    }
    
    func setUnFocussedState() {
        focussedView.isHidden = true
    }
    
    func setSelectedState() {
        if let menu = menu {
            menuIcon.image = UIImage(systemName: menu.selectedIcon)
            menuTitle.textColor = UIColor.white
        }
    }
    
    func setUnSelectedState() {
        if let menu = menu {
            menuIcon.image = UIImage(systemName: menu.unSelectedIcon)
            menuTitle.textColor = UIColor(red: 190/255, green: 190/255, blue: 190/255, alpha: 1)
        }
    }
}

struct Menu {
    var id: String
    var unSelectedIcon: String
    var titleName: String
    var selectedIcon: String
    var isSelected: Bool
}

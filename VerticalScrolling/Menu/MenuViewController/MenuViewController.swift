//
//  MenuViewController.swift
//  VerticalScrolling
//
//  Created by SaiKiran Panuganti on 29/09/23.
//

import UIKit

enum menuVisibilty : Int {
    case hidden
    case collapsed
    case expanded
}

class MenuViewController: UIViewController {
    @IBOutlet weak var menuTableView: UITableView!
    
    var menuState:menuVisibilty = .hidden
    var menus: [Menu] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        menuTableView.register(UINib(nibName: "MenuTableViewCell", bundle: nil), forCellReuseIdentifier: "MenuTableViewCell")
        menuTableView.dataSource = self
        menuTableView.delegate = self
        menuTableView.remembersLastFocusedIndexPath = true
        
        createMenuData()
        menuTableView.reloadData()
    }

    func createMenuData() {
        menus = []
        
        menus.append(Menu(id: "search", unSelectedIcon: "magnifyingglass.circle", titleName: "Search", selectedIcon: "magnifyingglass.circle.fill", isSelected: false))
        menus.append(Menu(id: "home", unSelectedIcon: "house", titleName: "Home", selectedIcon: "house.fill", isSelected: false))
        menus.append(Menu(id: "movies", unSelectedIcon: "photo", titleName: "Movies", selectedIcon: "photo.fill", isSelected: false))
        menus.append(Menu(id: "tvshows", unSelectedIcon: "play.tv", titleName: "TV Shows", selectedIcon: "play.tv.fill", isSelected: false))
        menus.append(Menu(id: "mylist", unSelectedIcon: "plus.app", titleName: "My List", selectedIcon: "plus.app.fill", isSelected: false))
        menus.append(Menu(id: "new", unSelectedIcon: "star.square.on.square", titleName: "New", selectedIcon: "star.square.on.square.fill", isSelected: false))
        menus.append(Menu(id: "settings", unSelectedIcon: "gearshape", titleName: "Settings", selectedIcon: "gearshape.fill", isSelected: false))
    }
    
    func tableView(_ tableView: UITableView, didUpdateFocusIn context: UITableViewFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        if let previousCell = context.previouslyFocusedView as? MenuTableViewCell {
            previousCell.setUnFocussedState()
        }
        
        if let nextCell = context.nextFocusedView as? MenuTableViewCell {
            nextCell.setFocussedState()
        }
    }
}

extension MenuViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menus.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let menuCell = menuTableView.dequeueReusableCell(withIdentifier: "MenuTableViewCell", for: indexPath) as? MenuTableViewCell {
            menuCell.configureUI(menu: menus[indexPath.row])
            menuCell.focusStyle = .custom
            menuCell.selectedBackgroundView = UIView()
            return menuCell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if menus.count > 0 {
            return CGFloat(1080 - (menus.count*(90+15)))/2
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if menus.count > 0 {
            return CGFloat(1080 - (menus.count*(90+15)))/2
        }
        return 0
    }
}

extension MenuViewController: UITableViewDelegate {
    
}

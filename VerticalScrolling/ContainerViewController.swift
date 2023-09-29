//
//  ContainerViewController.swift
//  VerticalScrolling
//
//  Created by SaiKiran Panuganti on 29/09/23.
//

import UIKit

class ContainerViewController: UIViewController {
    @IBOutlet weak var menuContainer: UIView!
    @IBOutlet weak var homeContainer: UIView!
    @IBOutlet weak var sideMenuWidth: NSLayoutConstraint!
    @IBOutlet weak var homeLeadingConstraint: NSLayoutConstraint!
    
    var menuViewController: MenuViewController?
    
    override var preferredFocusEnvironments: [UIFocusEnvironment] {
        if homeContainer == nil {
            return []
        }else {
            return [homeContainer]
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        homeLeadingConstraint.constant = AppConstants.sideMenuMinWidth
        sideMenuWidth.constant = AppConstants.sideMenuMinWidth

        if let menuVC: MenuViewController = loadVCFromNib() {
            self.menuViewController = menuVC
            self.addChildController(childController: menuVC, containerView: menuContainer)
        }
        
        if let homeVC: HomeViewController = loadVCFromNib() {
            self.addChildController(childController: homeVC, containerView: homeContainer)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        addFocusGuide(from: menuViewController!.view, to: homeContainer, direction: .right)
    }

    private func addChildController(childController: UIViewController, containerView: UIView) {
//        childController.view.translatesAutoresizingMaskIntoConstraints = false
        self.addChild(childController)
        childController.view.frame = containerView.bounds
        containerView.addSubview(childController.view)
        childController.didMove(toParent: self)
    }
    
    func openSideMenu() {
        sideMenuWidth.constant = AppConstants.sideMenuMaxWidth
        self.menuViewController?.menuState = .expanded
    }
    
    func closeSideMenu() {
        sideMenuWidth.constant = AppConstants.sideMenuMinWidth
        self.menuViewController?.menuState = .collapsed
    }
    
    override func shouldUpdateFocus(in context: UIFocusUpdateContext) -> Bool {
        guard let menuView = menuViewController?.view else { return true }
        if (context.nextFocusedView?.isDescendant(of: menuView) ?? false) {
            if(menuViewController?.menuState != menuVisibilty.expanded) {
                openSideMenu()
            }
        }else if(menuViewController?.menuState != menuVisibilty.collapsed && menuViewController?.menuState != menuVisibilty.hidden) {
            closeSideMenu()
        }
        return true
    }
    
    @discardableResult func addFocusGuide(from origin: UIView, to destination: UIView, direction: UIRectEdge) -> UIFocusGuide {
         let focusGuide = UIFocusGuide()
         view.addLayoutGuide(focusGuide)
         focusGuide.preferredFocusEnvironments = [destination]
         
         // Configure size to match origin view
         focusGuide.widthAnchor.constraint(equalTo: origin.widthAnchor).isActive = true
         focusGuide.heightAnchor.constraint(equalTo: origin.heightAnchor).isActive = true
         
         switch direction {
         case .bottom: // swipe down
             focusGuide.topAnchor.constraint(equalTo: origin.bottomAnchor).isActive = true
             focusGuide.leftAnchor.constraint(equalTo: origin.leftAnchor).isActive = true
         case .top: // swipe up
             focusGuide.bottomAnchor.constraint(equalTo: origin.topAnchor).isActive = true
             focusGuide.leftAnchor.constraint(equalTo: origin.leftAnchor).isActive = true
         case .left: // swipe left
             focusGuide.topAnchor.constraint(equalTo: origin.topAnchor).isActive = true
             focusGuide.rightAnchor.constraint(equalTo: origin.leftAnchor).isActive = true
         case .right: // swipe right
             focusGuide.topAnchor.constraint(equalTo: origin.topAnchor).isActive = true
             focusGuide.leftAnchor.constraint(equalTo: origin.rightAnchor).isActive = true
         default:
             // Not supported :(
             break
         }
         
         return focusGuide
     }
}

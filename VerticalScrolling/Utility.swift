//
//  Utility.swift
//  VerticalScrolling
//
//  Created by SaiKiran Panuganti on 29/09/23.
//

import UIKit


public func loadVCFromNib<T: UIViewController>() -> T? {
    return T(nibName: String(describing: T.self), bundle: nil)
}

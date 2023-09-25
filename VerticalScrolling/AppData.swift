//
//  AppData.swift
//  VerticalScrolling
//
//  Created by SaiKiran Panuganti on 23/09/23.
//

import Foundation

class AppData {
    private init () { }
    
    static let shared: AppData = AppData()
    
    var preferredPositionShouldY: CGFloat? = nil
    var preferredPositionDidY: CGFloat? = nil
    var preferredPositionShouldX: CGFloat? = nil
    var preferredPositionDidX: CGFloat? = nil
}

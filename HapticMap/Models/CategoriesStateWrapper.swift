//
//  CategoriesStateWrapper.swift
//  HapticMap
//
//  Created by Duran Timothée on 22.12.21.
//

import Foundation

/// Wrapper class conforming to *Identifiable* and *Equatable* procotols reprensenting a category setting.
struct CategoriesStateWrapper: Identifiable, Equatable {
    
    /// A UUID unrelated to the feedback but used by SwiftUI.
    let id = UUID()
    
    /// The wrapped category.
    var category: Category
    
    /// Indicates if the category is switched on or off.
    var isOn: Bool
    
}

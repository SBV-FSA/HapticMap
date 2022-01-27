//
//  URL + humanReadableName.swift
//  HapticMap
//
//  Created by Duran Timothée on 25.10.21.
//

import Foundation

extension URL {
    
    /// A human-readable file name using the URL. It takes the last path component, replaces `_` and `-` with spaces and capitalize the result.
    var humanReadableName: String {
        let rawName = deletingPathExtension().lastPathComponent
        let cleanedName = rawName
            .replacingOccurrences(of: "_", with: " ")
            .replacingOccurrences(of: "-", with: " ")
        return cleanedName.lowercased().capitalized
    }

}

//
//  DictionaryUrl.swift
//  RecipeYum
//
//  Created by Atsuki on 2023-10-16.
//

import Foundation
extension Dictionary where Key == String, Value == String {
    var urlEncodedString: String {
        let pairs = self.map { key, value in
            return "\(key)=\(value.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)"
        }
        return pairs.joined(separator: "&")
    }
}

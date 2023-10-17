//
//  Extensions.swift
//  RecipeYum
//
//  Created by Neil CAO on 2023-10-16.
//

import Foundation

extension Encodable {
   func asDictionary() -> [String: Any] {
      guard let data = try? JSONEncoder().encode(self) else {
         return [:]
      }
      
      do {
         let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
         return json ?? [:]
      } catch {
         return [:]
      }
               
   }
}


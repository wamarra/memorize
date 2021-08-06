//
//  Array+Identifiable.swift
//  Memorize
//
//  Created by Wesley Marra on 06/08/21.
//

import Foundation

extension Array where Element: Identifiable {
    
    func firstIndex(matching: Element) -> Int? {
        
        for index in 0..<count {
            if self[index].id == matching.id {
                return index
            }
        }
        
        return nil
    }
}

//
//  Array+OnlyOrNothing.swift
//  Memorize
//
//  Created by Wesley Marra on 06/08/21.
//

import Foundation

extension Array {
    
    var only: Element? {
        count == 1 ? first : nil
    }
}

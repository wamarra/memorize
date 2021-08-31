//
//  Theme.swift
//  Memorize
//
//  Created by Wesley Marra on 26/08/21.
//

import SwiftUI

struct Theme<CardContent>: Identifiable where CardContent: Equatable {
    
    var id = UUID()
    let cardFaceOptions: [CardContent]
    let details: [String: Any]
    let name: String
}

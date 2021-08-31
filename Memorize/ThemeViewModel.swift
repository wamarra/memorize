//
//  ThemeViewModel.swift
//  Memorize
//
//  Created by Wesley Marra on 26/08/21.
//

import SwiftUI

class ThemeViewModel: ObservableObject {
    
    @Published
    var model = [
        Theme<String>(
            cardFaceOptions: ["⚽️","🥋","⛷","🚴🏻‍♀️","🏊‍♀️","🏒","🏹","🚣‍♀️"],
            details: ["color": Color.red, "cornerRadius": 8],
            name: "Sports"),
        
        Theme<String>(
            cardFaceOptions: ["🚗","🛻","🛺","🛳","🚢","✈️","🛩","🚆"],
            details: ["color": Color.purple, "cornerRadius": 16],
            name: "Vehicles"),
        
        Theme<String>(
            cardFaceOptions: ["🍑","🍓","🍉","🥝","🍐","🍍","🍇","🍎"],
            details: ["color": Color.blue, "cornerRadius": 24],
            name: "Fruits"),

        ]
    
    // MARK: - Acesso da View à Model
    
    var themeNames: [String] {
        model.map({$0.name})
    }
    
    func themeFor(name: String) -> Theme<String> {
        return model.first(where: {$0.name == name})!
    }
    
    // MARK: - Processamento de Intenções
}

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
            cardFaceOptions: ["β½οΈ","π₯","β·","π΄π»ββοΈ","πββοΈ","π","πΉ","π£ββοΈ"],
            details: ["color": Color.red, "cornerRadius": 8],
            name: "Sports"),
        
        Theme<String>(
            cardFaceOptions: ["π","π»","πΊ","π³","π’","βοΈ","π©","π"],
            details: ["color": Color.purple, "cornerRadius": 16],
            name: "Vehicles"),
        
        Theme<String>(
            cardFaceOptions: ["π","π","π","π₯","π","π","π","π"],
            details: ["color": Color.blue, "cornerRadius": 24],
            name: "Fruits"),

        ]
    
    // MARK: - Acesso da View Γ  Model
    
    var themeNames: [String] {
        model.map({$0.name})
    }
    
    func themeFor(name: String) -> Theme<String> {
        return model.first(where: {$0.name == name})!
    }
    
    // MARK: - Processamento de IntenΓ§Γ΅es
}

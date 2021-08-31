//
//  CardMaker.swift
//  Memorize
//
//  Created by Wesley Marra on 06/08/21.
//

import SwiftUI

struct CardMaker: ViewModifier {
    
    var isFaceUp: Bool
    
    var cornerRadius: CGFloat
    let lineWidth: CGFloat = 4
    
    private var rotation: Double
    
    init(isFaceUp: Bool, cornerRadius: CGFloat) {
        self.isFaceUp = isFaceUp
        self.rotation = isFaceUp ? 0 : 180
        self.cornerRadius = cornerRadius
    }
    
    func body(content: Content) -> some View {
        ZStack {
            Group {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(Color.white)
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(lineWidth: lineWidth)
                content
            }.opacity(isFaceUp ? 1 : 0)
            
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill()
                .opacity(isFaceUp ? 0 : 1)
        }
        .padding(EdgeInsets(top: 0, leading: 4, bottom: 0, trailing: 4))
        .rotation3DEffect(.degrees(rotation), axis: (0, 1, 0))
    }
}

extension View {
    
    func makeCard(isFaceUp: Bool = false, cornerRadius: CGFloat) -> some View {
        return self.modifier(CardMaker(isFaceUp: isFaceUp, cornerRadius: cornerRadius))
    }
}

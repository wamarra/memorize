//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Wesley Marra on 06/08/21.
//

import SwiftUI

// ViewModel do MVVM
class EmojiMemoryGame: ObservableObject {
    
    var theme: Theme<String>
    
    @Published
    var model: MemoryGame<String>
    
    init(theme: Theme<String>) {
        self.theme = theme
        self.model = EmojiMemoryGame.createMemoryGame(theme: theme)
    }
    
    static func createMemoryGame(theme: Theme<String>) -> MemoryGame<String>  {
//        let emojis = ["⚽️", "🥎", "🎱", "🏀", "🏈", "⚾️", "🏐", "🎾", "🏉"].shuffled()
        let emojis = theme.cardFaceOptions.shuffled()
        return MemoryGame(numberOfPairsOfCards: Int.random(in: 2..<6)) { emojis[$0] }
    }
    
    // MARK: - Acesso da View à Model
    
    var cards: Array<MemoryGame<String>.Card> {
        print(model.cards)
        return model.cards
    }
    
    var gameHasEnded: Bool {
        model.gameHasEnded
    }
    
    var calculateScore: Int {
        model.calculateScore
    }
    
    var statistic: MemoryGame<String>.Statistic {
        model.statistic
    }
    
    var themeColor: Color {
        (theme.details["color"] as? Color) ?? Color.black
    }
    
    var themeCornerRadius: CGFloat {
        CGFloat(theme.details["cornerRadius"] as? Int ?? 8)
    }
    
    // MARK: - Processamento de Intenções
    
    func choose(card: MemoryGame<String>.Card, difficulty: Double) {
        model.choose(card: card, difficulty: difficulty)
    }
    
    func newGame() {
        model = EmojiMemoryGame.createMemoryGame(theme: theme)
    }
}

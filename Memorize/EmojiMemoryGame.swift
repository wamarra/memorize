//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Wesley Marra on 06/08/21.
//

import Foundation

// ViewModel do MVVM
class EmojiMemoryGame: ObservableObject {
    
    @Published
    var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
    
    static func createMemoryGame() -> MemoryGame<String>  {
        let emojis = ["⚽️", "🥎", "🎱", "🏀", "🏈", "⚾️", "🏐", "🎾", "🏉"].shuffled()
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
    
    // MARK: - Processamento de Intenções
    
    func choose(card: MemoryGame<String>.Card, difficulty: Double) {
        model.choose(card: card, difficulty: difficulty)
    }
    
    func newGame() {
        model = EmojiMemoryGame.createMemoryGame()
    }
}

//
//  MemoryGame.swift
//  Memorize
//
//  Created by Pedro Henrique on 29/07/21.
//

import Foundation


//Model do MVVM
struct MemoryGame<CardContent> where CardContent: Equatable {
    
    var cards: Array<Card> // é a mesma coisa de var cartas: [Card]
    
    private var indexOfPreviousChosenCard: Int?
    
    
    /*
     
     1- Gerar cartas - criar partida
     2- Função para escolher uma carta
     3- Detectar fim do jogo
     
     */
    
//    func createCard(pairIndex) -> CardContent {
//
//    }
    
    
    init(numberOfPairsOfCards: Int, cardFactory: (Int) -> CardContent) {
        
        cards = Array<Card>()
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = cardFactory(pairIndex)
            cards.append(Card(id: pairIndex * 2, content: content))
            cards.append(Card(id: pairIndex * 2 + 1, content: content))
        }
        
        cards.shuffle()
    }
    
    
    mutating func choose(card: Card) {
        print("Carta escolhida: \(card)")
        
        if let chosenCardIndex = cards.firstIndex(matching: card) { //desencapsulamento de opcional
            
            if let possibleMatch = indexOfPreviousChosenCard {
                if cards[chosenCardIndex].content == cards[possibleMatch].content {
                    cards[chosenCardIndex].isMatched = true
                    cards[possibleMatch].isMatched = true
                }
            }else {
                indexOfPreviousChosenCard = chosenCardIndex
            }
            
            cards[chosenCardIndex].isFaceUp = true
        }
        
    }
    
    
    struct Card: Identifiable {
        var id: Int
        
        var isFaceUp: Bool = false
        
        var isMatched: Bool = false
        
        var content: CardContent
        
    }
    
}

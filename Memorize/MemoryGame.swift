//
//  MemoryGame.swift
//  Memorize
//
//  Created by Wesley Marra on 06/08/21.
//

import Foundation

//Model do MVVM
struct MemoryGame<CardContent> where CardContent: Equatable {
    
    var cards: Array<Card> // é a mesma coisa de var cartas: [Card]
    
    private var indexOfPreviousChosenCard: Int? {
        get {
            cards.indices.filter { cards[$0].isFaceUp }.only
        }
        set {
            cards.indices.forEach { cards[$0].isFaceUp = $0 == newValue }
        }
    }
    
    var gameHasEnded: Bool {
        cards.allSatisfy { $0.isMatched }
    }
    
    var timeRemaining: Int {
        var bonusTimeRemaining = 0.0
        
        for card in cards {
            if card.isMatched {
                print("Tempo de bonus restante: \(card.bonusTimeRemaining)")
                bonusTimeRemaining += card.bonusTimeRemaining
            }
        }
        return Int(bonusTimeRemaining)
    }
    
    var calculateScore: Int {
        let totalTime = cards.count * 10
        return timeRemaining * 100 / totalTime
    }
    
    var totalTimeCards: Int {
        cards.count * 10
    }
    
    var statistic: Statistic {
        Statistic (
            cardsTotal: cards.count, totalTime: totalTimeCards, spendTime: totalTimeCards - timeRemaining, score: calculateScore
        )
    }
    
    init(numberOfPairsOfCards: Int, cardFactory: (Int) -> CardContent) {
        
        cards = Array<Card>()
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = cardFactory(pairIndex)
            cards.append(Card(id: pairIndex * 2, content: content))
            cards.append(Card(id: pairIndex * 2 + 1, content: content))
        }
        
        cards.shuffle()
    }
    
    mutating func choose(card: Card, difficulty: Double) {
        print("Carta escolhida: \(card)")
        
        if let chosenCardIndex = cards.firstIndex(matching: card) { //desencapsulamento de opcional
            
            if let possibleMatch = indexOfPreviousChosenCard {
                if cards[chosenCardIndex].content == cards[possibleMatch].content
                    && cards[chosenCardIndex].id != cards[possibleMatch].id {
                    cards[chosenCardIndex].isMatched = true
                    cards[possibleMatch].isMatched = true
                }
            }else {
                indexOfPreviousChosenCard = chosenCardIndex
            }
            
            cards[chosenCardIndex].isFaceUp = true
            cards[chosenCardIndex].difficulty = difficulty
        }
    }
    
    struct Statistic {
        var cardsTotal: Int
        var totalTime: Int
        var spendTime: Int
        var score: Int
    }
    
    struct Card: Identifiable {
        var id: Int
        var difficulty: Double = 0
        var content: CardContent
        var bonusTime: TimeInterval = 10
        var lastTimeFacingUp: Date?
        var lastIntervalFacingUp: TimeInterval = 0
        
        var isFaceUp: Bool = false {
            didSet {
                if isFaceUp {
                    beginUsingBonusTime()
                } else {
                    stopUsingBonusTime()
                }
            }
        }
        
        var isMatched: Bool = false {
            didSet {
                stopUsingBonusTime()
            }
        }
        
        var bonusTimeRemaining: TimeInterval {
            max(0, bonusTime - timeFacingUp)
        }
        
        var bonusRemaining: Double {
            (bonusTime > 0 && bonusTimeRemaining > 0) ? bonusTimeRemaining / bonusTime : 0
        }
        
        var isConsumingBonusTime:  Bool {
            isFaceUp && !isMatched && bonusTimeRemaining > 0
        }
        
        private var timeFacingUp: TimeInterval {
            if let lastFlip = lastTimeFacingUp {
                return lastIntervalFacingUp + Date().addingTimeInterval(difficulty).timeIntervalSince(lastFlip)
            }
            return lastIntervalFacingUp
        }
        
        private mutating func beginUsingBonusTime() {
            if lastTimeFacingUp == nil {
                lastTimeFacingUp = Date()
            }
        }
        
        private mutating func stopUsingBonusTime() {
            lastIntervalFacingUp = timeFacingUp
            lastTimeFacingUp = nil
        }
    }
}

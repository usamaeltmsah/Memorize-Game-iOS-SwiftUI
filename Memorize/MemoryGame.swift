//
//  MemoryGame.swift
//  Memorize
//
//  Created by Usama Fouad on 06/01/2022.
//

import Foundation

// Model
struct MemoryGame<CardContent> {
    private(set) var cards: Array<Card>
    
    mutating func choose(_ card: Card) {
        let chosenInd = index(of: card)
        cards[chosenInd].isFaceUP.toggle()
    }
    
    func index(of card: Card) -> Int {
        for index in 0..<cards.count {
            if cards[index].id == card.id {
                return index
            }
        }
        return -1
    }
    
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = Array<Card>()
        // Add numberOfPairsOfCards x 2 cards array
        for pairIndex in 0..<numberOfPairsOfCards {
            let content: CardContent = createCardContent(pairIndex)
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex*2+1))
        }
    }
    
    struct Card: Identifiable {
        var isFaceUP: Bool = true
        var isMatched: Bool = false
        var content: CardContent
        
        var id: Int
        
        mutating func flipCard() {
            isFaceUP.toggle()
        }
    }
}

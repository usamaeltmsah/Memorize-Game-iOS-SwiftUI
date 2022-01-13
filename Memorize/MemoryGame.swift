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
        if let chosenInd = cards.firstIndex(where: { $0.id == card.id }) {
            cards[chosenInd].isFaceUP.toggle()
        }
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

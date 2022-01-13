//
//  MemoryGame.swift
//  Memorize
//
//  Created by Usama Fouad on 06/01/2022.
//

import Foundation

// Model
struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int?
    mutating func choose(_ card: Card) {
        if let chosenInd = cards.firstIndex(where: { $0.id == card.id }),
           !cards[chosenInd].isFaceUP,
           !cards[chosenInd].isMatched
        {
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                if cards[chosenInd].content == cards[potentialMatchIndex].content {
                    cards[chosenInd].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                }
                indexOfTheOneAndOnlyFaceUpCard = nil
            } else {
                for index in cards.indices {
                    cards[index].isFaceUP = false
                }
                indexOfTheOneAndOnlyFaceUpCard = chosenInd
            }
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
        var isFaceUP: Bool = false
        var isMatched: Bool = false
        var content: CardContent
        
        var id: Int
        
        mutating func flipCard() {
            isFaceUP.toggle()
        }
    }
}

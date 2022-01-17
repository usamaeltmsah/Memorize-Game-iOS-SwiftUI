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
    var selectedTheme: Theme<CardContent>?
    
    private(set) var score: Int = 0
    
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
                    score += 2
                } else if cards[potentialMatchIndex].isSeen && cards[chosenInd].isSeen {
                    score -= 1
                }
                
                indexOfTheOneAndOnlyFaceUpCard = nil
            } else {
                for index in cards.indices {
                    cards[index].isFaceUP = false
                }
                indexOfTheOneAndOnlyFaceUpCard = chosenInd
            }
            cards[chosenInd].isFaceUP.toggle()
            cards[chosenInd].isSeen = true
        }
    }
    
    init(theme: Theme<CardContent>, numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        selectedTheme = theme
        var n = numberOfPairsOfCards
        if n > selectedTheme?.emojis.count ?? 10 {
            n = selectedTheme?.emojis.count ?? 0
        }
        cards = []
        // Add numberOfPairsOfCards x 2 cards array
        for pairIndex in 0..<n {
            let content: CardContent = createCardContent(pairIndex)
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex*2+1))
        }
        
        cards.shuffle()
    }
    
    struct Card: Identifiable {
        var isFaceUP = false
        var isMatched = false
        var isSeen = false
        let content: CardContent
        let id: Int
        
        mutating func flipCard() {
            isFaceUP.toggle()
        }
    }
}

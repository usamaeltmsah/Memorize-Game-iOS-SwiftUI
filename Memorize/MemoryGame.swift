//
//  MemoryGame.swift
//  Memorize
//
//  Created by Usama Fouad on 06/01/2022.
//

import Foundation

struct MemoryGame<CardContent> {
    var cards: Array<Card>
    
    func choose(_ card: Card) {
        
    }
    
    struct Card {
        var isFaceUP: Bool
        var isMatched: Bool
        var content: CardContent
    }
}

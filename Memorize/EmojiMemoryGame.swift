//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Usama Fouad on 06/01/2022.
//

import SwiftUI

class EmojiMemoryGame {
    static let emojis = ["😤", "😅", "🤓", "😰", "🍏", "🍍", "🧇", "🍔", "🍟", "🥨", "🍲", "🍙", "🍰", "🥜", "🍿", "🍶", "🍺", "🏀", "🏹", "🥢"]
    
    static func createMemoryGame() -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairsOfCards: 4) { pairIndex in
            EmojiMemoryGame.emojis[pairIndex]
        }
    }
    
    private var model: MemoryGame<String> = createMemoryGame()
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
}

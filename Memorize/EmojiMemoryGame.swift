//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Usama Fouad on 06/01/2022.
//

import SwiftUI


// ViewModel
class EmojiMemoryGame: ObservableObject {
    static let emojis = ["😤", "😅", "🤓", "😰", "🍏", "🍍", "🧇", "🍔", "🍟", "🥨", "🍲", "🍙", "🍰", "🥜", "🍿", "🍶", "🍺", "🏀", "🏹", "🥢"]
    
    static func createMemoryGame() -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairsOfCards: 10) { pairIndex in
            EmojiMemoryGame.emojis[pairIndex]
        }
    }
        
    @Published private var model: MemoryGame<String> = createMemoryGame()
    
    var cards: Array<MemoryGame<String>.Card> { model.cards }
    
    // MARK: - Intent(s)
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
}

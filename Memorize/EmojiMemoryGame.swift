//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Usama Fouad on 06/01/2022.
//

import SwiftUI


// ViewModel
class EmojiMemoryGame: ObservableObject {
    static var selectedTheme: Theme<String>?
    
    static private let emojis = ["😤", "😅", "🤓", "😰", "🍏", "🍍", "🧇", "🍔", "🍟", "🥨", "🍲", "🍙", "🍰", "🥜", "🍿", "🍶", "🍺", "🏀", "🏹", "🥢"]

    private static let theme1 = Theme(name: "Theme 1", emojis: emojis.shuffled(), numberOfPairs: 5, color: Color.yellow)
    private static let theme2 = Theme(name: "Theme 2", emojis: emojis.shuffled(), numberOfPairs: 7, color: Color.blue)
    private static let theme3 = Theme(name: "Theme 3", emojis: emojis.shuffled(), numberOfPairs: 15, color: Color.brown)
    private static let theme4 = Theme(name: "Theme 4", emojis: emojis.shuffled(), numberOfPairs: 18, color: Color.orange)
    private static let theme5 = Theme(name: "Theme 5", emojis: emojis.shuffled(), numberOfPairs: 3, color: Color.purple)
    private static let theme6 = Theme(name: "Theme 6", emojis: emojis.shuffled(), numberOfPairs: 20, color: Color.mint)
    
    static private let themes = [theme1, theme2, theme3, theme4, theme5, theme6]
    
    static func createMemoryGame(_ theme: Theme<String>) -> MemoryGame<String> {
        MemoryGame<String>(theme: theme, numberOfPairsOfCards: theme.numberOfPairs) { pairIndex in
            selectedTheme?.emojis[pairIndex] ?? ""
        }
    }
        
    @Published private var model: MemoryGame<String> = createMemoryGame(randomTheme() ?? theme1)
    
    var cards: Array<MemoryGame<String>.Card> { model.cards }
    
    // MARK: - Intent(s)
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
    
    static private func randomTheme() -> Theme<String>? {
        selectedTheme = themes.randomElement()
        return selectedTheme
    }
}

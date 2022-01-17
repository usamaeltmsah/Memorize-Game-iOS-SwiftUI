//
//  ContentView.swift
//  Memorize
//
//  Created by Usama Fouad on 31/12/2021.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    // viewModel Object
    @ObservedObject var game: EmojiMemoryGame
    
    var body: some View {
        VStack(alignment: .trailing) {
            HStack {
                Text(EmojiMemoryGame.selectedTheme?.name ?? "")
                    .padding()
                Spacer()
                Text("Score: \(game.getScore())").foregroundColor(.cyan).font(.largeTitle)
                Spacer()
                Text("New Game")
                    .foregroundColor(.blue)
                    .padding()
                    .onTapGesture {
                    game.newGame()
                }
            }
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                    ForEach(game.cards) { card in
                        CardView(card)
                            .aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                game.choose(card)
                            }
                    }
                }
            }
            .padding(.horizontal)
        }
        .foregroundColor(EmojiMemoryGame.selectedTheme?.color ?? .red)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        EmojiMemoryGameView(game: game)
            .preferredColorScheme(.dark)
        EmojiMemoryGameView(game: game)
            .preferredColorScheme(.light)
    }
}


struct CardView: View {
    private let card: EmojiMemoryGame.Card
    
    init(_ card: EmojiMemoryGame.Card) {
        self.card = card
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
                if card.isFaceUP {
                    shape.fill().foregroundColor(.white)
                    shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
                    Text(card.content)
                        .font(font(in: geometry.size))
                } else if card.isMatched {
                    shape.opacity(0)
                }
                else {
                    shape.fill()
                }
            }
        }
    }
    
    private func font(in size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height) * DrawingConstants.fontScale)
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 20
        static let lineWidth: CGFloat = 3
        static let fontScale: CGFloat = 0.8
    }
}

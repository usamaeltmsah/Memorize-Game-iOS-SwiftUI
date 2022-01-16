//
//  ContentView.swift
//  Memorize
//
//  Created by Usama Fouad on 31/12/2021.
//

import SwiftUI

struct ContentView: View {
    // viewModel Object
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        VStack(alignment: .trailing) {
            HStack {
                Text(EmojiMemoryGame.selectedTheme?.name ?? "")
                    .padding()
                Spacer()
                Text("Score: \(viewModel.getScore())").foregroundColor(.cyan).font(.largeTitle)
                Spacer()
                Text("New Game")
                    .foregroundColor(.blue)
                    .padding()
                    .onTapGesture {
                    viewModel.newGame()
                }
            }
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                    ForEach(viewModel.cards) { card in
                        CardView(card: card)
                            .aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                viewModel.choose(card)
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
        ContentView(viewModel: game)
            .preferredColorScheme(.dark)
        ContentView(viewModel: game)
            .preferredColorScheme(.light)
    }
}


struct CardView: View {
    let card: MemoryGame<String>.Card
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            if card.isFaceUP {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(card.content)
                    .font(.largeTitle)
            } else if card.isMatched {
                shape.opacity(0)
            }
            else {
                shape.fill()
            }
        }
    }
}

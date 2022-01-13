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
    
    @State var emojis = ["😤", "😅", "🤓", "😰", "🍏", "🍍", "🧇", "🍔", "🍟", "🥨", "🍲", "🍙", "🍰", "🥜", "🍿", "🍶", "🍺", "🏀", "🏹", "🥢"]
    let vehiclesEmojis = ["🚓", "🚕", "🚔", "🚖", "🚗", "🚘", "🚙", "🏎", "🚁", "🚀", "🚂", "🚃", "🚎", "🚢", "🛺", "🛳", "🛬", "🚜"]
    let fruitsEmojis = ["🍏", "🍎", "🍐", "🍊", "🍋", "🍌", "🍉", "🍇", "🍓", "🫐", "🍈", "🍒", "🍑", "🥭", "🍍", "🥥", "🥝", "🥑"]
    let animalsEmojis = ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐻‍❄️", "🐨", "🐯", "🦁", "🐮", "🐷", "🐽", "🐸", "🐵", "🙈", "🙉", "🐤"]
    @State var emojiCount = 11
    var random: Int {
        Int.random(in: 4..<fruitsEmojis.count)
    }
    
    @State var selectedButtonInd: Int?
    var body: some View {
        VStack {
            Text("Memorize!")
                .font(.largeTitle)
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
                .foregroundColor(.red)
            }
            Spacer(minLength: 20)
                
            HStack {
                VStack(alignment: .center) {
                    vehicles
                    Text("Vehicles")
                        .font(.caption)
                }
                Spacer()
                VStack(alignment: .center) {
                    fruits
                    Text("Fruits")
                        .font(.caption)
                }
                Spacer()
                VStack(alignment: .center) {
                    animals
                    Text("Animals")
                        .font(.caption)
                }
            }
            .padding(.horizontal)
            .font(.largeTitle)
            .foregroundColor(.blue)

        }
        .padding()
    }
    
    var vehicles: some View {
        Button {
            emojiCount = random
            emojis = vehiclesEmojis.shuffled()
        } label: {
            Image(systemName: "car")
        }
    }
    
    var fruits: some View {
        Button {
            emojiCount = random
            emojis = fruitsEmojis.shuffled()
        } label: {
            Image(systemName: "applelogo")
        }
    }
    
    var animals: some View {
        Button {
            emojiCount = random
            emojis = animalsEmojis.shuffled()
        } label: {
            Image(systemName: "tortoise")
        }
    }
    
    func widthThatBestFits(cardCount: Int) -> CGFloat {
        UIScreen.main.bounds.width / CGFloat(cardCount - 1)
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

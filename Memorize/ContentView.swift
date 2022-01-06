//
//  ContentView.swift
//  Memorize
//
//  Created by Usama Fouad on 31/12/2021.
//

import SwiftUI

struct ContentView: View {
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
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 40 ,maximum: widthThatBestFits(cardCount: emojiCount)))]) {
                    ForEach(emojis[0..<emojiCount], id: \.self) { emoji in
                        CardView(content: emoji, isFaceUP: true)
                            .aspectRatio(2/3, contentMode: .fit)
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
    
//    var remove: some View {
//        Button {
//            if emojiCount > 1 { emojiCount -= 1 }
//        } label: {
//            Image(systemName: "minus.circle")
//        }
//    }
//
//    var add: some View {
//        Button {
//            if emojiCount < emojis.count { emojiCount += 1 }
//        } label: {
//            Image(systemName: "plus.circle")
//        }
//    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
        ContentView()
            .preferredColorScheme(.light)
    }
}


struct CardView: View {
    var content: String
    @State var isFaceUP: Bool
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            if isFaceUP {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(content)
                    .font(.largeTitle)
            } else {
                shape.fill()
            }
        }
        .onTapGesture {
            isFaceUP.toggle()
        }
    }
}

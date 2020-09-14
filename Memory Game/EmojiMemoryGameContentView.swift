//
//  EmojiMemoryGameContentView.swift
//  Memory Game
//
//  Created by Damasya on 9/9/20.
//  Copyright © 2020 Damir Miniakhmetov. All rights reserved.
//

import SwiftUI

struct EmojiMemoryGameContentView: View {
    @ObservedObject var viewModel: EmojiMemoryGameViewModel
    
    var body: some View {
        Grid(items: viewModel.cards) { card in
                CardView(card: card).onTapGesture{
                    self.viewModel.choose(card: card)
                }
            //.aspectRatio(3/3, contentMode: .fit)
            .padding()
            }
        .padding()
        .foregroundColor(Color.orange)
        }
    }

struct CardView: View {
    var card: MemoryGameModel<String>.Card
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                if self.card.isFaceUp {
                    RoundedRectangle(cornerRadius: self.cornerRadius).fill(Color.white)
                    RoundedRectangle(cornerRadius: self.cornerRadius).stroke(lineWidth: self.lineWidth)
                    Text(self.card.content)
                } else {
                    RoundedRectangle(cornerRadius: self.cornerRadius).fill()
                }
            }
            .font(Font.system(size: min(geometry.size.width, geometry.size.height) * self.fontScale))
        }
    }
    var cornerRadius: CGFloat = 10.0
    var lineWidth: CGFloat = 3.0
    var fontScale: CGFloat = 0.75
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameContentView(viewModel: EmojiMemoryGameViewModel())
    }
}

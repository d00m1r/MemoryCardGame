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
        VStack(alignment: .center){
            Text("Score: \(viewModel.score)")
                .foregroundColor(Color.gray)
                .font(.title)
            Grid(items: viewModel.cards) { card in
                CardView(card: card).onTapGesture{
                    self.viewModel.choose(card: card)
                }
                .padding(self.gridPaddingLength)
            }
            .padding(.horizontal, paddingLength)
            .foregroundColor(Color("middleBlue"))
            Button(action: {
                self.viewModel.resetGame()
            }) {
                Text("New game")
                    .padding(TextPaddingLength)
                    .foregroundColor(Color.white)
                    .background(LinearGradient(gradient: Gradient(colors: [Color("LightBlue"), Color("LightPink")]), startPoint: .leading, endPoint: .trailing))
                    .font(.title)
                    .cornerRadius(10)
            }.padding(.bottom)
        }
        .padding(.horizontal, paddingLength)
    }
    var paddingLength : CGFloat = 5.0
    var TextPaddingLength : CGFloat = 15.0
    var gridPaddingLength : CGFloat = 3.0
}

struct CardView: View {
    var card: MemoryGameModel<String>.Card
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                if self.card.isFaceUp {
                    RoundedRectangle(cornerRadius: self.cornerRadius).fill(LinearGradient(gradient: Gradient(colors: [Color("LightBlue"), Color("LightPink")]), startPoint: .leading, endPoint: .trailing))
                    RoundedRectangle(cornerRadius: self.cornerRadius).stroke(lineWidth: self.lineWidth)
                    Text(self.card.content)
                } else {
                    if !self.card.isMatched{
                        RoundedRectangle(cornerRadius: self.cornerRadius).fill()
                    }
                    //emptyView here
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

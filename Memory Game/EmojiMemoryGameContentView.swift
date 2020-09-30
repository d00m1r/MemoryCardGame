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
            self.body(in: geometry.size)
        }
    }
    
    @ViewBuilder
    private func body (in size: CGSize) -> some View {
        if  card.isFaceUp || !card.isMatched{
            ZStack {
                Text(self.card.content)
                    .font(Font.system(size: min(size.width, size.height) * self.fontScale))
            }
            .cardify(isFaceUp: self.card.isFaceUp)
        }
    }
    var fontScale: CGFloat = 0.75
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGameViewModel()
        game.choose(card: game.cards[0])
        return EmojiMemoryGameContentView(viewModel: game)
    }
}

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
                    withAnimation(Animation.linear(duration: animationDuration)){
                        self.viewModel.choose(card: card)
                    }
                }
                .padding(self.gridPaddingLength)
            }
            .padding(.horizontal, paddingLength)
            .foregroundColor(Color("middleBlue"))
            Button(action: {
                withAnimation(Animation.easeIn(duration: buttonAnimationDuration)){
                    self.viewModel.resetGame()
                }
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
    let animationDuration = 0.75
    let buttonAnimationDuration = 0.35
    let paddingLength : CGFloat = 5.0
    let TextPaddingLength : CGFloat = 15.0
    let gridPaddingLength : CGFloat = 3.0
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
                PacmanFigure(startAngle:Angle.degrees(270), endAngle: Angle.degrees(0-30), clockwise: true).foregroundColor(.white).opacity(circleOpacity).padding(circlePadding)
                Text(self.card.content)
                    .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                    .animation(card.isMatched ? Animation.linear(duration: 1).repeatForever(autoreverses: false) : .default)
                    .font(Font.system(size: min(size.width, size.height) * self.fontScale))
            }
            .cardify(isFaceUp: self.card.isFaceUp)
            .transition(.scale)
        }
    }
    let circleOpacity: Double = 0.5
    let fontScale: CGFloat = 0.6
    let circlePadding: CGFloat = 6
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGameViewModel()
        game.choose(card: game.cards[0])
        return EmojiMemoryGameContentView(viewModel: game)
    }
}

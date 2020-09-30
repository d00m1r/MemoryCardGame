//
//  EmojiMemoryGameViewModel.swift
//  Memory Game
//
//  Created by Damasya on 9/9/20.
//  Copyright © 2020 Damir Miniakhmetov. All rights reserved.
//
//ViewModel
import SwiftUI

class EmojiMemoryGameViewModel: ObservableObject {
    @Published private var model: MemoryGameModel<String> =
        EmojiMemoryGameViewModel.createMemoryGame()
    
    private static func createMemoryGame()-> MemoryGameModel<String> {
        let emojis: [[String]] = [animalsEmojis, facesEmojis, fruitsEmojis, flagsEmojis]
        let randomThemeIndex = Int.random(in: 0..<emojis.count)
        return MemoryGameModel<String>(numberOfGroupsOfCards: emojis[randomThemeIndex].count)
        { groupIndex in return emojis[randomThemeIndex][groupIndex] }
    }
    
    // MARK: - Access to the Model
    
    var cards : Array<MemoryGameModel<String>.Card> {
        return model.cards
    }
    
    var score : Int {
        return model.score
    }
    
    // MARK: - Intent(s)
    
    func choose (card: MemoryGameModel<String>.Card){
        //objectWillChange.send()
        model.choose(card: card)
    }
    
    func resetGame (){
        model = EmojiMemoryGameViewModel.createMemoryGame()
    }
    
    private static let animalsEmojis  = ["🦊","🐰","🐻","🐵","🐷","🦁","🐭","🐶"]
    private static let facesEmojis = ["😆","😂","😇","😚","😋","😎","🤪","🥺"]
    private static let fruitsEmojis = ["🍎","🍊","🍌","🍉","🥝","🍑","🥭","🍐"]
    private static let flagsEmojis = ["🇬🇧","🇮🇹","🇷🇺","🇺🇦","🇰🇿","🇯🇵","🇩🇪","🇰🇷"]
}

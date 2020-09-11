//
//  EmojiMemoryGame.swift
//  Memory Game
//
//  Created by Damasya on 9/9/20.
//  Copyright © 2020 Damir Miniakhmetov. All rights reserved.
//
//ViewModel
import SwiftUI

class EmojiMemoryGame: ObservableObject {
    @Published private var model: MemoryGame<String> =
                               EmojiMemoryGame.createMemoryGame()
    
    static func createMemoryGame()-> MemoryGame<String> {
        let emojis  = ["🦊","🐰","🐻"]
        return MemoryGame<String>(numberOfGroupsOfCards: emojis.count)
               { groupIndex in return emojis[groupIndex] }
    }
    
    // MARK: - Access to the Model
    
    var cards : Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    // MARK: - Intent(s)
    
    func choose (card: MemoryGame<String>.Card){
        //objectWillChange.send()
        model.choose(card: card)
    }
}

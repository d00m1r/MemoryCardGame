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
    
    static func createMemoryGame()-> MemoryGameModel<String> {
        let emojis  = ["🦊","🐰","🐻"]
        return MemoryGameModel<String>(numberOfGroupsOfCards: emojis.count)
               { groupIndex in return emojis[groupIndex] }
    }
    
    // MARK: - Access to the Model
    
    var cards : Array<MemoryGameModel<String>.Card> {
        return model.cards
    }
    
    // MARK: - Intent(s)
    
    func choose (card: MemoryGameModel<String>.Card){
        //objectWillChange.send()
        model.choose(card: card)
    }
}

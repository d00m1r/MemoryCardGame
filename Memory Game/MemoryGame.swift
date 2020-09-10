//
//  MemoryGame.swift
//  Memory Game
//
//  Created by Damasya on 9/9/20.
//  Copyright © 2020 Damir Miniakhmetov. All rights reserved.
//
//Model
import Foundation

struct MemoryGame <CardContent> {
    var cards : Array<Card>
    
    func choose(card:Card) {
        print("card chosen: \(card)")
    }
    
    init (numberOfGroupsOfCards: Int, numberOfCardsInGroup: Int = 2,
           cardContentFactory: (Int) -> CardContent) {
        cards = Array<Card>()
        for groupIndex in 0..<numberOfGroupsOfCards {
            let content = cardContentFactory(groupIndex)
            for index in 0..<numberOfCardsInGroup {
                cards.append(Card(content: content, id: groupIndex * numberOfCardsInGroup + index))
            }
        }
        cards.shuffle()
    }
    
    struct Card: Identifiable {
        var isFaceUp: Bool = true
        var isMatched: Bool = false
        var content: CardContent
        var id: Int
    }
}

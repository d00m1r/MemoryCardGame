//
//  MemoryGameModel.swift
//  Memory Game
//
//  Created by Damasya on 9/9/20.
//  Copyright © 2020 Damir Miniakhmetov. All rights reserved.
//
//Model
import Foundation

//class DeallocPrinter {
//    deinit {
//        print("deallocated")
//    }
//}

struct MemoryGameModel <CardContent> where CardContent: Equatable {
    //    let printer = DeallocPrinter()
    private(set) var cards : Array<Card> //anybody can't modify but can read
    private(set) var score = 0 // +10 if cards matched, -5 if dismatched
    private let cardsMatched = 10
    private let cardsDismatched = 5
    private var indexOneAndOnlyFaceUpCard: Int? {
        get { cards.indices.filter { (index) -> Bool in cards[index].isFaceUp}.only }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = index == newValue
            }
        }
    }
    
    mutating func choose(card:Card) {
        if let choosenIndex: Int = cards.firstIndex(of: card), !cards[choosenIndex].isFaceUp, !cards[choosenIndex].isMatched{
            if let potentialMatchIndex = indexOneAndOnlyFaceUpCard{
                if cards[choosenIndex].content == cards[potentialMatchIndex].content{
                    cards[choosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    score += cardsMatched
                }
                else { score -= cardsDismatched }
                self.cards[choosenIndex].isFaceUp = true
            } else { indexOneAndOnlyFaceUpCard = choosenIndex }
        }
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
        //        print("struct init")
    }
    
    
    struct Card: Identifiable {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
        var id: Int
    }
}

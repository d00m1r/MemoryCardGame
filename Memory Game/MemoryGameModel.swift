//
//  MemoryGameModel.swift
//  Memory Game
//
//  Created by Damasya on 9/9/20.
//  Copyright © 2020 Damir Miniakhmetov. All rights reserved.
//
//Model
import Foundation

struct MemoryGameModel <CardContent> where CardContent: Equatable {
    var cards : Array<Card>
    var indexOneAndOnlyFaceUpCard: Int? {
        get {
            var faceUpCardIndecies = [Int]()
            for index in cards.indices{
                if cards[index].isFaceUp{ faceUpCardIndecies.append(index) }
            }
            if faceUpCardIndecies.count == 1{ return faceUpCardIndecies.first }
            else { return nil }
        }
        set {
            for index in cards.indices {
                if index == newValue { cards[index].isFaceUp = true }
                else { cards[index].isFaceUp = false }
            }
        }
    }
    
    mutating func choose(card:Card) {
        if let choosenIndex: Int = cards.firstIndex(of: card), !cards[choosenIndex].isFaceUp, !cards[choosenIndex].isMatched{
            if let potentialMatchIndex = indexOneAndOnlyFaceUpCard{
                if cards[choosenIndex].content == cards[potentialMatchIndex].content{
                    cards[choosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                }
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
    }
    
    struct Card: Identifiable {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
        var id: Int
    }
}

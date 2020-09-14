//
//  Grid.swift
//  Memory Game
//
//  Created by Damasya on 9/14/20.
//  Copyright © 2020 Damir Miniakhmetov. All rights reserved.
//

import SwiftUI

struct Grid<Item, itemView>: View where Item: Identifiable, itemView: View {
    var items: [Item]
    var viewForItem:  (Item) -> itemView
    
    init(items: [Item], viewForItem: @escaping(Item) -> itemView){
        self.items = items
        self.viewForItem = viewForItem
    }
    
    var body: some View {
        GeometryReader{ geometry in
            self.body(for: GridLayout(itemCount: self.items.count, in: geometry.size))
        }
    }
    
    func body(for layout: GridLayout) -> some View{
        ForEach(self.items){ item in
            self.body(for: item, in: layout)
        }
    }
    
    func body(for item: Item, in layout: GridLayout) -> some View {
        let index = items.firstIndex(of: item)!
        return self.viewForItem(item)
            .frame(width: layout.itemSize.width, height: layout.itemSize.height)
            .position(layout.location(ofItemAt: index))
    }
}



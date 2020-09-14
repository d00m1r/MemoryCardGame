//
//  Array + index.swift
//  Memory Game
//
//  Created by Damasya on 9/14/20.
//  Copyright © 2020 Damir Miniakhmetov. All rights reserved.
//

import Foundation

extension Array where Element: Identifiable {
    func firstIndex(of matching: Element) -> Int? {
        for index in 0..<self.count{
            if self[index].id == matching.id { return index }
        }
        return nil
    }
}

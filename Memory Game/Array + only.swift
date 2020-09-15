//
//  Array + only.swift
//  Memory Game
//
//  Created by Damasya on 9/15/20.
//  Copyright © 2020 Damir Miniakhmetov. All rights reserved.
//

import Foundation

extension Array {
    var only: Element? {
        count == 1 ? first:nil
    }
}

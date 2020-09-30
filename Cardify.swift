//
//  SwiftUIView.swift
//  Memory Game
//
//  Created by Damasya on 9/30/20.
//  Copyright © 2020 Damir Miniakhmetov. All rights reserved.
//

import SwiftUI

struct Cardify: ViewModifier {
    var isFaceUp: Bool
    func body(content: Content) -> some View {
        ZStack {
            if isFaceUp {
                RoundedRectangle(cornerRadius: self.cornerRadius).fill(LinearGradient(gradient: Gradient(colors: [Color("LightBlue"), Color("LightPink")]), startPoint: .leading, endPoint: .trailing))
                RoundedRectangle(cornerRadius: self.cornerRadius).stroke(lineWidth: self.lineWidth)
                content
            } else { RoundedRectangle(cornerRadius: self.cornerRadius).fill() }
        }
    }
    let cornerRadius: CGFloat = 10.0
    let lineWidth: CGFloat = 3.0
}

extension View{
    func cardify (isFaceUp: Bool) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceUp))
    }
}

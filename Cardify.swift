//
//  SwiftUIView.swift
//  Memory Game
//
//  Created by Damasya on 9/30/20.
//  Copyright © 2020 Damir Miniakhmetov. All rights reserved.
//

import SwiftUI

struct Cardify: AnimatableModifier {
    var rotation: Double
    var isFaceUp: Bool{
        rotation < 90
    }
    var animatableData: Double{
        get{ rotation }
        set{ rotation = newValue}
    }
    init(isFaceUp: Bool){
        rotation = isFaceUp ? 0 : 180
    }
    func body(content: Content) -> some View {
        ZStack {
            Group {
                RoundedRectangle(cornerRadius: self.cornerRadius).fill(LinearGradient(gradient: Gradient(colors: [Color("LightBlue"), Color("LightPink")]), startPoint: .leading, endPoint: .trailing))
                RoundedRectangle(cornerRadius: self.cornerRadius).stroke(lineWidth: self.lineWidth)
                content
            }.opacity(isFaceUp ? 1 : 0)
            RoundedRectangle(cornerRadius: self.cornerRadius).fill()
                .opacity(isFaceUp ? 0 : 1)
        }
        .rotation3DEffect(Angle.degrees(rotation), axis: /*@START_MENU_TOKEN@*/(x: 0.0, y: 1.0, z: 0.0)/*@END_MENU_TOKEN@*/)
    }
    let cornerRadius: CGFloat = 10.0
    let lineWidth: CGFloat = 3.0
}

extension View{
    func cardify (isFaceUp: Bool) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceUp))
    }
}

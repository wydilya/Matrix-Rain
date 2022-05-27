//
//  MatrixRainView.swift
//  MatrixRainView
//
//  Created by Ilya Zelkin on 26.05.2022.
//


import SwiftUI

struct MatrixRainView: View {
    
    // MARK: Animation properties
    @State var startAnimation: Bool = false
    var body: some View {
        GeometryReader{ proxy in
            let size = proxy.size
            
            HStack(spacing: 15){
                ForEach(1...Int((size.width / 25)),id: \.self){_ in
                    MatrixRainCharacters(size: size)
                }
                
            }
            .padding(.horizontal)
        }
    }
}

struct MatrixRainCharacters: View {
    var size: CGSize
    @State var startAnimation:Bool = false
    @State var random: Int = 0
    
    var body: some View {
        // Random Height
        let randomHeight:CGFloat = .random(in: (size.height / 2)...size.height)
        VStack{
            // MARK: Iterating String
            ForEach(0..<constant.count,id: \.self){index in
                
                //Retriving character at String
                let character = Array(constant)[getRandomIndex(index: index)]
                
                Text(String(character))
                    .font(.custom("matrix code nfi", size: 25))
                    .foregroundColor(Color("Green"))
            }
        }
        // Fade like Animation Using Mask
        .mask(alignment: .top, {
            Rectangle()
                .fill(
                    LinearGradient(colors: [
                        .clear,
                        .black.opacity(0.1),
                        .black.opacity(0.2),
                        .black.opacity(0.3),
                        .black.opacity(0.5),
                        .black.opacity(0.7),
                        .black
                    ], startPoint: .top, endPoint: .bottom)
                )
                .frame(height: size.height / 2)
            // Animating
                .offset(y: startAnimation ? size.height : -randomHeight)
        })
        .onAppear{
            // Moving Slowly down with linear Animation
            //Endless loop without reversing
            //Random delay for more fleunt Effect
            withAnimation(.linear(duration: 12).delay(.random(in: 0...2)).repeatForever(autoreverses:false)){
                startAnimation = true
            }
        }
        // Timer
        .onReceive(Timer.publish(every: 0.2, on: .main, in: .common).autoconnect()){ _ in
            random = Int.random(in: 0..<constant.count)
        }
    }
    
    // Randomize Characters with a Timer
    func getRandomIndex(index: Int)->Int{
        // To avoid index out bound range
        let max = constant.count - 1
        
        if (index  + random) > max {
            if (index - random) < 0 {
                return index
            }
            return (index - random)
        }
        else {
            return (index + random)
        }
    }
    
}

struct MatrixRainView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// MARK: Random Characters
let constant = "abcdefghijklmnopqrstuvwxyz1234567890"

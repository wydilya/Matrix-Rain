//
//  ContentView.swift
//  MatrixRainView
//
//  Created by Ilya Zelkin on 26.05.2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack{
            Color.black
            
            MatrixRainView()
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

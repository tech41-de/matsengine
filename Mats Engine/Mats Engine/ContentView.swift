//
//  ContentView.swift
//  Mats Engine
//
//  Created by Mathias Dietrich on 31.12.23.
//

import SwiftUI
import cengine


struct ContentView: View {
    
    // let main = Main()
    @State var debug = "starting"
    
    func testCall(){
    }
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("\(debug)")
        }
        .padding()
        .onAppear(){
            debug = " engine says \(setupEngine())"
        }
    }
}

#Preview {
    ContentView()
}

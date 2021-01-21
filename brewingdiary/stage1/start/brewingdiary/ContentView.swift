//
//  ContentView.swift
//  brewingdiary
//
//  Created by Stefan Zapf on 18.01.21.
//

import SwiftUI

struct ContentView: View {
    // 1. add a coffee bean collection
    // 2. try to recreate the interface as defined in \StageGoals\stage1.jpg 
    var body: some View {
        VStack{
            Text("Hello, world!")
                .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        // set up a coffee bean collection with test data from samples
    }
}

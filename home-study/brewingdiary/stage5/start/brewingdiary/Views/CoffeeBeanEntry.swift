//
//  CoffeeBeanEntry.swift
//  BrewingDiary
//
//  Created by Stefan Zapf on 05.11.20.
//

import SwiftUI

struct CoffeeBeanEntry: View {
    @ObservedObject var bean: CoffeeBean
    
    var body: some View {
        HStack {
            bean.displayImage.resizable()
                .frame(width: 50, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .clipShape(Circle())
                .shadow(radius: 3)
                .overlay(Circle().stroke(Color.yellow, lineWidth: 3))
                .padding()
            
            VStack {
                Text(bean.name).font(.title3).bold()
                
                // 1. update with actual distance
                Text("(42.0)")
            }.foregroundColor(.white)
            Spacer()
        }
        .background(Color.black)
        
    }
}

struct CoffeeBeanEntry_Previews: PreviewProvider {
    static var previews: some View {
        CoffeeBeanEntry(bean: muhondoBean)
    }
}

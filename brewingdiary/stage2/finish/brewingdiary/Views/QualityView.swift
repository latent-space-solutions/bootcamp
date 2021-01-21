//
//  QualityView.swift
//  BrewingDiary
//
//  Created by Stefan Zapf on 10.11.20.
//

import SwiftUI


struct QualityView: View {
    let maxQuality = 5
    var color: Color = .yellow
    @Binding var quality: Int
    
    var body: some View {
        
        HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 5) {
            ForEach((1 ... maxQuality), id: \.self ) { currenQuality in
                Button(action: {
                    quality = currenQuality
                }, label: {
                    if (currenQuality <= quality) {
                        Image(systemName: "star.fill")
                    } else {
                        Image(systemName: "star")
                    }
                })
                
            }
            
        }.foregroundColor(color)
    }
    
    
}

struct QualityView_Previews: PreviewProvider {
    static var previews: some View {
        
        QualityView(color: .yellow, quality: Binding.constant(3)).background(Color.black)
        
    }
}


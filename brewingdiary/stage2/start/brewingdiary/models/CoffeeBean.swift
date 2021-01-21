//
//  CoffeeBean2.swift
//  brewingdiary
//
//  Created by Stefan Zapf on 18.01.21.
//

import Foundation

class CoffeeBean: Identifiable, ObservableObject {
    
    var id: String = UUID().uuidString
    @Published var name: String
    let image: String

    //1. Add an attribute "diaryEntries" for holding the diary entries of type [DiaryEntry], make it published
    //2. Add an attribute "selectedEntry" for holding the diary entry the user has selected of type DiaryEntry, make it published
    
    
    init(name: String, image:String) {
        self.name = name
        self.image = image
        // 3. initialize diaryEntries
        
        // 4. select the topEntry from diaryEntries as the selectedEntry
    }
}

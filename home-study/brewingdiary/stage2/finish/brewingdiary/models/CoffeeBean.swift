//
//  CoffeeBean2.swift
//  brewingdiary
//
//  Created by Stefan Zapf on 18.01.21.
//

import Foundation
import SwiftUI

class CoffeeBean: Identifiable, ObservableObject, Equatable {
    var id: String = UUID().uuidString
    @Published var name: String
    let image: String
    @Published var diaryEntries: [DiaryEntry]
    @Published var selectedEntry: DiaryEntry
    
    static func == (lhs: CoffeeBean, rhs: CoffeeBean) -> Bool {
        lhs.id == rhs.id
    }
    
    var displayImage: Image {
        return Image(image)
    }
    
    init(name: String, image:String, diaryEntries: [DiaryEntry]) {
        self.name = name
        self.image = image
        self.diaryEntries = diaryEntries
        self.selectedEntry = diaryEntries.topEntry
    }
}

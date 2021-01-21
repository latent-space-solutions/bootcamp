//
//  DiaryEntry.swift
//  brewingdiary
//
//  Created by Stefan Zapf on 19.01.21.
//

import Foundation

class DiaryEntry {
    // 1. Add Observable Protocol
    // 2. Add Identifiable
    // 3. Add an attribute "grindSize" for grind size of type Double, make it published
    // 4. Add an attribute "temperature" for water temperature of type Double, make it published
    // 5. Add an attribute "stars" for the stars you give the diary entry of type Int, make it published
    
}


func nullDiaryEntry() -> DiaryEntry {
    // 6. Define a null diary entry
    return DiaryEntry()
}

extension Array where Element: DiaryEntry {
    var topEntry: DiaryEntry {
        self.sortedByQuality.first ?? nullDiaryEntry()
    }
    
    var sortedByQuality: [DiaryEntry] {
        // 7. sort by quality and if quality is equal, sort by date, newest first
        return self
    }
}

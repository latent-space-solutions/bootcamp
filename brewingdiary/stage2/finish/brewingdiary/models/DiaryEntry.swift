//
//  DiaryEntry.swift
//  brewingdiary
//
//  Created by Stefan Zapf on 19.01.21.
//

import Foundation

class DiaryEntry: Identifiable, ObservableObject, Equatable {
    var id: String = UUID().uuidString
    let date: Date
    @Published var grindSize: Double
    var grindSizeString: String {
        String(Int(grindSize))
    }
    @Published var temperature: Double
    var temperatureString: String {
        String(format: "%.1f", temperature)
    }
    
    @Published var quality: Int
    
    static func == (lhs: DiaryEntry, rhs: DiaryEntry) -> Bool {
        lhs.id == rhs.id
    }
    init(date: Date, grindSize: Double, temperature: Double, quality: Int) {
        self.date = date
        self.grindSize = grindSize
        self.temperature = temperature
        self.quality = quality
    }
}


func nullDiaryEntry() -> DiaryEntry {
    return DiaryEntry(date: Date(), grindSize: 18.0, temperature: 92.0, quality: 3)
}

extension Array where Element: DiaryEntry {
    var topEntry: DiaryEntry {
        self.sortedByQuality.first ?? nullDiaryEntry()
    }
    
    var sortedByQuality: [DiaryEntry] {
        // 7. sort by quality and if quality is equal, sort by date, newest first
        return self.sorted(by: {
            if $0.quality == $1.quality {
                return $0.date > $1.date
            } else {
                return $0.quality > $1.quality
            }
        })
    }
}

//
//  DiaryEntry.swift
//  brewingdiary
//
//  Created by Stefan Zapf on 19.01.21.
//

import Foundation

class DiaryEntry: Identifiable, ObservableObject, Equatable, Codable {
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
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        date = try container.decode(Date.self, forKey: .date)
        grindSize = try container.decode(Double.self, forKey: .grindSize)
        temperature = try container.decode(Double.self, forKey: .temperature)
        quality = try container.decode(Int.self, forKey: .quality)
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case date
        case grindSize
        case temperature
        case quality
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(date, forKey: .date)
        try container.encode(grindSize, forKey: .grindSize)
        try container.encode(temperature, forKey: .temperature)
        try container.encode(quality, forKey: .quality)
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
        return self.sorted(by: {
            if $0.quality == $1.quality {
                return $0.date > $1.date
            } else {
                return $0.quality > $1.quality
            }
        })
    }
}

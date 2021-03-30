//
//  CoffeeBean2.swift
//  brewingdiary
//
//  Created by Stefan Zapf on 18.01.21.
//

import Foundation
import SwiftUI

class CoffeeBean: Identifiable, ObservableObject, Equatable, Codable {
    var id: String = UUID().uuidString
    @Published var name: String
    let image: String
    @Published var diaryEntries: [DiaryEntry]
    @Published var selectedEntry: DiaryEntry
    // 1. Add distance to reference image, i.e. current image captured by the camera
    @Published var distance: Float = Float.infinity
    
    static func == (lhs: CoffeeBean, rhs: CoffeeBean) -> Bool {
        lhs.id == rhs.id
    }
    
    var imageUrl: URL {
        FileManager.documentsUrl.appendingPathComponent(image)
    }
    
    var _uiImage: UIImage? = nil
    var uiImage: UIImage {
        if _uiImage == nil {
            if image.starts(with: "Sample") {
                _uiImage = UIImage(named: image)
            } else {
                _uiImage = loadImage()
            }
        }
        return _uiImage!
    }
    
    func loadImage() -> UIImage? {
        do {
            let data = try Data(contentsOf: imageUrl)
            let image = UIImage(data: data)
            return image 
        } catch {
            fatalError("Couldn't load image")
        }

    }
    
    func deleteImage() -> Void {
        if image.starts(with: "Sample") {
            return
        }
        
        do {
            if FileManager.default.fileExists(atPath: imageUrl.path)  {
                try FileManager.default.removeItem(atPath: imageUrl.path)
            }
        } catch {
            print("Couldn't delete \(image) because \(error))")
        }
    }
    
    var displayImage: Image {
        return Image(uiImage: uiImage)
    }
    
    init(name: String, image:String, diaryEntries: [DiaryEntry]) {
        self.name = name
        self.image = image
        self.diaryEntries = diaryEntries
        self.selectedEntry = diaryEntries.topEntry
    }
    
    
    convenience init(id: String, name: String,  diaryEntries: [DiaryEntry], image: String) {
        self.init(name: name, image: image, diaryEntries: diaryEntries)
        self.id = id
    }
    
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        let entries = try container.decode(Array<DiaryEntry>.self, forKey: .diaryEntries)
        diaryEntries = entries
        image = try container.decode(String.self, forKey: .image)
        selectedEntry = entries[0]
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case diaryEntries
        case image
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(diaryEntries, forKey: .diaryEntries)
        try container.encode(image, forKey: .image)
    }
}

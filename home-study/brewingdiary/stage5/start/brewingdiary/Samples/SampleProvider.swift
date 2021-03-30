//
//  SampleProvider.swift
//  brewingdiary
//
//  Created by Stefan Zapf on 18.01.21.
//

import Foundation
import SwiftUI


let sampleJoseMayo = "SampleJoseMayo"
let sampleMonCherry = "SampleMonCherry"
let sampleMuhondo = "SampleMuhondo"

let muhondoBean = CoffeeBean(name: "Ruanda Muhondo", image: sampleMuhondo, diaryEntries: [nullDiaryEntry()])
let joseMayoBean = CoffeeBean(name: "Ecuador Jose Mayo", image: sampleJoseMayo, diaryEntries: [nullDiaryEntry()])
let monCherryBean = CoffeeBean(name: "Uganda Mon Cherry", image: sampleMonCherry, diaryEntries: [nullDiaryEntry()])
let nullBean = CoffeeBean(name: "default", image: "SampleCamMonCheri1", diaryEntries: [DiaryEntry(date: Date(), grindSize: 18.0, temperature: 92.0, quality: 3)])

struct CameraImages {
    let images = ["SampleCamJoseMayo1",
                    "SampleCamJoseMayo2",
                    "SampleCamMonCheri1",
                    "SampleCamMonCheri2",
                    "SampleCamMuhondo1",
                    "SampleCamMuhondo2"].shuffled()

    var currentIdx = 0
    
    mutating func next() -> Void {
        currentIdx = (currentIdx + 1) % images.count
    }
    
    func current() -> String {
        return images[currentIdx]
    }
}

extension String {
    func toImage() -> Image {
        Image(self)
    }
}

extension Array where Element == String {
    func toImage() -> [Image] {
        self.map {
            Image($0)
        }
    }
}

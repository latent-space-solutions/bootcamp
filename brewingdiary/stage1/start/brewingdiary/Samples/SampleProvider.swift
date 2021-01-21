//
//  SampleProvider.swift
//  brewingdiary
//
//  Created by Stefan Zapf on 18.01.21.
//

import Foundation
import SwiftUI


let sampleJoseMayo = "SampleJoseMayo".toImage()
let sampleMonCherry = "SampleMonCherry".toImage()
let sampleMuhondo = "SampleMuhondo".toImage()

struct CameraImages {
    let images = ["SampleCamJoseMayo1",
                    "SampleCamJoseMayo2",
                    "SampleCamMonCheri1",
                    "SampleCamMonCheri2",
                    "SampleCamMuhondo1",
                    "SampleCamMuhondo2"].toImage().shuffled()

    var currentIdx = 0
    
    mutating func next() -> Image {
        currentIdx = (currentIdx + 1) % images.count
        return current()
    }
    
    func current() -> Image {
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

//
//  VisionObjectRecognitionView.swift
//  BrewingDiary
//
//  Created by Till Lohfink on 23.11.20.
//

import SwiftUI

struct CameraView: View {
    // 1. Add a binding 
    @ObservedObject var coffeeBeans: CoffeeBeanCollection
    @Binding var showSelectedBean: Bool
    @Binding var addNewBagOfBeans: Bool
    var body: some View {
        
        CameraViewControllerRepresentable(coffeeBeansCollection: coffeeBeans, addNewBagOfBeans: $addNewBagOfBeans, showSelectedBean: $showSelectedBean)
        
    }
}


struct VisionObjectRecognitionView_Previews: PreviewProvider {
    static var previews: some View {
        CameraView(coffeeBeans: CoffeeBeanCollection(), showSelectedBean: Binding.constant(false), addNewBagOfBeans: Binding.constant(false))
    }
}

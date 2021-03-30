/*
 See LICENSE folder for this sample’s licensing information.
 
 Abstract:
 Contains the object recognition view controller for the Breakfast Finder.
 */

import UIKit
import AVFoundation
import SwiftUI
import VideoToolbox



final class CameraUIViewController: CameraViewController {
    private var detectionOverlay: CALayer! = nil
    weak var updateBeansDelegate: CoffeeBeanUpdateDelegate?
    var captureImage: Bool = false
    var coffeeBeans: [CoffeeBean] = []
    var pause: Bool = false

    
    override func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        if pause{
            return
        }
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {
            return
        }
        
        if captureImage {
            
            do {
                captureImage = false
                updateBeansDelegate?.disableCapture()
                let ciImage = CIImage(cvPixelBuffer: pixelBuffer)
                let image = UIImage(ciImage: ciImage, scale: 1.0, orientation: .right)
                let imageId = UUID().uuidString
                if let data = image.pngData() {
                    try data.write(to: FileManager.documentsUrl.appendingPathComponent(imageId).appendingPathExtension("png"))
                    let coffeeId = UUID().uuidString
                    DispatchQueue.main.async(execute: {
                        let diaryEntry = DiaryEntry(date: Date(), grindSize: 15.0, temperature: 95.0, quality: 3)
                        let coffeeBean = CoffeeBean(id: coffeeId, name: "New Entry", diaryEntries: [diaryEntry], image: imageId + ".png")
                        self.updateBeansDelegate?.addNewEntry(coffeeBean)
                        
                    })
                }
            } catch let error {
                print(error)
            }
        }
    }
    
    override func setupAVCapture() {
        super.setupAVCapture()
        
        // start the capture
        startCaptureSession()
    }
    
    
    
}

protocol CoffeeBeanUpdateDelegate: class {
    func updateSelectedBean(_ bean: CoffeeBean)
    func addNewEntry(_ bean: CoffeeBean)
    func disableCapture()
}

struct CameraViewControllerRepresentable: UIViewControllerRepresentable {
    @ObservedObject var coffeeBeansCollection: CoffeeBeanCollection
    @Binding var addNewBagOfBeans: Bool
    @Binding var showSelectedBean: Bool
    
    class Coordinator: CoffeeBeanUpdateDelegate {
        
        
        var parent: CameraViewControllerRepresentable
        
        init(_ parent: CameraViewControllerRepresentable) {
            self.parent = parent
        }
        
        func addNewEntry(_ bean: CoffeeBean) {
            parent.coffeeBeansCollection.coffeeBeans.append(bean)
            parent.coffeeBeansCollection.selectedBean = bean
            parent.showSelectedBean = true
        }
        
        
        func updateSelectedBean(_ bean: CoffeeBean) {
            parent.coffeeBeansCollection.selectedBean = bean
            parent.showSelectedBean = true
        }
        
        
        
        func disableCapture() {
            parent.addNewBagOfBeans = false
        }
    }
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    func makeUIViewController(context: Context) -> CameraUIViewController {
        let vc = CameraUIViewController()
        vc.updateBeansDelegate = context.coordinator
        return vc
    }
    
    func updateUIViewController(_ viewController: CameraUIViewController, context: Context) {
        viewController.captureImage = addNewBagOfBeans
        viewController.coffeeBeans = coffeeBeansCollection.coffeeBeans
        viewController.pause = showSelectedBean
    }
}

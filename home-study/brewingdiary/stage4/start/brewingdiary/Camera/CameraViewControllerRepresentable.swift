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

    // 1. add override
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        if pause{
            return
        }
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {
            return
        }
        
        if captureImage {
            
            do {
                // 2. save image to file system with guid as an image name
                // 3. use delegate to add new bean
            } catch let error {
                print(error)
            }
        }
    }
    
    // 4. overide capture session
    
}

protocol CoffeeBeanUpdateDelegate: class {
    func updateSelectedBean(_ bean: CoffeeBean)
    func addNewBean(_ bean: CoffeeBean)
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
        
        func addNewBean(_ bean: CoffeeBean) {
            // 5. add new coffee bean
        }
        
        
        func updateSelectedBean(_ bean: CoffeeBean) {
            
        }
        
        
        
        func disableCapture() {
            
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

//
//  brewingdiaryTests.swift
//  brewingdiaryTests
//
//  Created by Till Lohfink on 28.03.21.
//

import XCTest
import Vision


class brewingdiaryTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
    
        let imageA = UIImage(named: "SampleCamJoseMayo1")
        let imageB = UIImage(named: "SampleCamJoseMayo2")
        let imageC = UIImage(named: "SampleCamMonCheri1")
        
        let requestHandler = VNImageRequestHandler(cgImage: imageA!.cgImage!,  options: [:])
        let request = VNGenerateImageFeaturePrintRequest()
        
        
        try requestHandler.perform([request])
        let z = request.results?.first as? VNFeaturePrintObservation
        print(z!.data)
        

        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}

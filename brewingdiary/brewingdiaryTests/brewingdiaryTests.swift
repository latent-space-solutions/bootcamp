//
//  brewingdiaryTests.swift
//  brewingdiaryTests
//
//  Created by Till Lohfink on 28.03.21.
//

import XCTest
import Vision
import Accelerate

class brewingdiaryTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func getEmbedding(image: UIImage) -> [Float] {
        let featurePrint = getFeaturePrint(image: image)
        let embedding = featurePrint.data.withUnsafeBytes { (pointer: UnsafeRawBufferPointer) -> [Float] in
            let buffer = pointer.bindMemory(to: Float.self)
            return Array<Float>(buffer)
        }
        return embedding
    }
    
    func getFeaturePrint(image: UIImage) -> VNFeaturePrintObservation {
        let requestHandler = VNImageRequestHandler(cgImage: image.cgImage!,  options: [:])
        let request = VNGenerateImageFeaturePrintRequest()
        try! requestHandler.perform([request])
        let featurePrint = request.results!.first as! VNFeaturePrintObservation
        return featurePrint
    }
    
    func dot(a: [Float], b:[Float]) -> Float {
        var result: Float = 0
        
        for dim in 0..<a.count {
            result += a[dim] * b[dim]
        }
        // vDSP.dot(a, b)
        // result = zip(a,b).map({$0 * $1}).reduce(0, +)
        
        return result
    }
    func testDot() {
        let a: [Float] = [3,5,2]
        let b: [Float] = [7,3,3]
        
        let result = dot(a: a, b: b)
        XCTAssertEqual(result, 42)
    }
    
    func l2norm(a: [Float]) -> Float {
        let squareSum = dot(a: a, b: a)
        let squareRoot = sqrt(squareSum)
        
        return squareRoot
    }
    
    func testL2Norm(){
        let a: [Float] = [3, 4]
        let result = l2norm(a: a)
        XCTAssertEqual(result, 5)
    }
    
    func cosineSimliarity(a: [Float], b:[Float]) -> Float {
        dot(a: a, b: b) / (l2norm(a: a) * l2norm(a: b))
    }
    
    
    func testExample() throws {
        let imageA = UIImage(named: "SampleCamJoseMayo1")!
        let imageB = UIImage(named: "SampleCamJoseMayo2")!
        let imageC = UIImage(named: "SampleCamMonCheri1")!
        let imageD = UIImage(named: "nature")!
        
        
        let embeddingA = getEmbedding(image: imageA)
        let embeddingB = getEmbedding(image: imageB)
        let embeddingC = getEmbedding(image: imageC)
        let embeddingD = getEmbedding(image: imageD)
        let embeddings = [embeddingA, embeddingB, embeddingC, embeddingD]
        
        var similarityMatrix: [[Float]] = [[Float]]()
        
        for i in 0..<embeddings.count {
            var currentRow: [Float] = [Float]()
            for j in 0..<embeddings.count {
                currentRow.append(cosineSimliarity(a: embeddings[i], b: embeddings[j]))
            }
            similarityMatrix.append(currentRow)
        }
        
        for row in similarityMatrix {
            let stringRow = row.map { sim in String(format: "%.2f", sim)}
            print(stringRow)
        }
    }
    func cosineBlasSimilarity(data1: Data, data2: Data, count: Int32) -> Float {
        data1.withUnsafeBytes { (xRawPointer: UnsafeRawBufferPointer) in
            data2.withUnsafeBytes { (yRawPointer: UnsafeRawBufferPointer) in
                let x = xRawPointer.bindMemory(to: Float.self).baseAddress!
                let y = yRawPointer.bindMemory(to: Float.self).baseAddress!
                return cblas_sdot(count, x, 1, y, 1) / (cblas_snrm2(count, x, 1) * cblas_snrm2(count, x, 1))

            }
        }

//        data1.withUnsafeBytes { x in
//            data2.withUnsafeBytes { y in
//                cblas_sdot(count, x, 1, y, 1) / (cblas_snrm2(count, x, 1) * cblas_snrm2(count, x, 1))
//            }
//        }
    }
    
    func testSimilarityBlas() throws {
        let imageA = UIImage(named: "SampleCamJoseMayo1")!
        let imageB = UIImage(named: "SampleCamJoseMayo2")!
        let imageC = UIImage(named: "SampleCamMonCheri1")!
        let imageD = UIImage(named: "nature")!
        
        let embeddingA = getFeaturePrint(image: imageA)
        
        let embeddingB = getFeaturePrint(image: imageB)
        let embeddingC = getFeaturePrint(image: imageC)
        let embeddingD = getFeaturePrint(image: imageD)

        let embeddings = [embeddingA, embeddingB, embeddingC, embeddingD]
        
        var similarityMatrix: [[Float]] = [[Float]]()
        let cnt32 = Int32(embeddingA.elementCount)
        for i in 0..<embeddings.count {
            var currentRow: [Float] = [Float]()
            for j in 0..<embeddings.count {
                currentRow.append(cosineBlasSimilarity(data1: embeddings[i].data, data2: embeddings[j].data, count: cnt32))
            }
            similarityMatrix.append(currentRow)
        }
        
        for row in similarityMatrix {
            let stringRow = row.map { sim in String(format: "%.2f", sim)}
            print(stringRow)
        }
    }


}

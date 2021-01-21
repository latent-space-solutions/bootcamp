import CoreML

extension Array where Element: Comparable {
    func indicesOfLargest(_ count: Int = 10) -> [Int] {
        // create an extension that allows you to find the indices of the largest elements
        return [0]
    }
}

extension MLMultiArray {
    func doubleArray() -> [Double] {
        // Bind the underlying `dataPointer` memory to make a native swift `Array<Double>`
        let unsafeMutablePointer = dataPointer.bindMemory(to: Double.self, capacity: count)
        let unsafeBufferPointer = UnsafeBufferPointer(start: unsafeMutablePointer, count: count)
        return [Double](unsafeBufferPointer)
    }
}

extension DistilBert {
    
    func bestLogitsIndices(from prediction: distilbert_qaOutput, in range: Range<Int>) -> (start: Int, end: Int, bestSum: Float)? {
        // extract the start logits and end logits from distilbert output
        
        // keep the 10 largest start and end logits
        
        // Use findBestLogitPair to get the best pair
        
        return nil
    }
    
    func findBestLogitPair(startLogits: [Float32],
                           bestStartIndices: [Int],
                           endLogits: [Float32],
                           bestEndIndices: [Int]) -> (start: Int, end: Int, bestSum: Float32) {
        // We need to iterate through all possible pairs
        // possible means: start index < end index
        // add the start and end logit for each possible pair
        // keep the indices with the largest logit sum 
        return (start: 0, end: 11, bestSum: 42.0)
    }
}

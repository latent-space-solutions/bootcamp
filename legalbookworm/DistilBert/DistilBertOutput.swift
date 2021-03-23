import CoreML

extension Array where Element: Comparable {
    func indicesOfLargest(_ count: Int = 10) -> [Int] {
        // create an extension that allows you to find the indices of the largest elements
        let count = Swift.min(count, self.count)
        let sortedSelf = enumerated().sorted { (arg0, arg1) in arg0.element > arg1.element }
        let topElements = sortedSelf[0..<count]
        let topIndices = topElements.map { (tuple) in tuple.offset }
        return topIndices
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
        
        let endPtr = prediction.Identity.dataPointer.bindMemory(to: Float32.self, capacity: prediction.Identity.count)
        let endLogits = Array(UnsafeBufferPointer(start: endPtr, count: prediction.Identity.count))
        let startPtr = prediction.Identity_1.dataPointer.bindMemory(to: Float32.self, capacity: prediction.Identity_1.count)
        let startLogits = Array(UnsafeBufferPointer(start: startPtr, count: prediction.Identity_1.count))
        
        
        let startLogitsOfDoc = [Float32](startLogits)
        let endLogitsOfDoc = [Float32](endLogits)
        
        
        let bestPair = findMaxLogitPair(startLogits: startLogitsOfDoc,
                                         endLogits: endLogitsOfDoc)
        
        
//        let startLogitsOfDoc = [Float32](startLogits[range])
//        let endLogitsOfDoc = [Float32](endLogits[range])
//
//        let topStartIndices = startLogitsOfDoc.indicesOfLargest(20)
//        let topEndIndices = endLogitsOfDoc.indicesOfLargest(20)
//
//        let bestPair = findBestLogitPair(startLogits: startLogitsOfDoc,
//                                         bestStartIndices: topStartIndices,
//                                         endLogits: endLogitsOfDoc,
//                                         bestEndIndices: topEndIndices)
        
        guard bestPair.start >= 0 && bestPair.end >= 0 else {
            return nil
        }
        
        return bestPair
    }
    
    func findMaxLogitPair(startLogits: [Float32],
                           endLogits: [Float32]) -> (start: Int, end: Int, bestSum: Float32) {
        
        // Find the max logit for start and end of the answer
        var bestStartIndex: Int = -1
        var bestStartValue: Float = -1
        
        for index in startLogits.indices {
            let value = startLogits[index]
            
            if value > bestStartValue {
                bestStartValue = value
                bestStartIndex = index
            }
        }
        
        var bestEndIndex: Int = -1
        var bestEndValue: Float = -1
        
        for index in endLogits.indices {
            let value = endLogits[index]
            
            if value > bestEndValue {
                bestEndValue = value
                bestEndIndex = index
            }
        }
        
        let sum = bestStartValue + bestEndValue
        
        return (bestStartIndex, bestEndIndex, sum)
    }
    
    func findBestLogitPair(startLogits: [Float32],
                           bestStartIndices: [Int],
                           endLogits: [Float32],
                           bestEndIndices: [Int]) -> (start: Int, end: Int, bestSum: Float32) {
        // We need to iterate through all possible pairs
        // possible means: start index < end index
        // add the start and end logit for each possible pair
        // keep the indices with the largest logit sum 
        let logitsCount = startLogits.count
        var bestSum = -Float32.infinity
        var bestStart = -1
        var bestEnd = -1
        
        for start in 0..<logitsCount where bestStartIndices.contains(start) {
            for end in start..<logitsCount where bestEndIndices.contains(end) {
                let logitSum = startLogits[start] + endLogits[end]
                
                if logitSum > bestSum {
                    bestSum = logitSum
                    bestStart = start
                    bestEnd = end
                }
            }
        }
        
        return (bestStart, bestEnd, bestSum)
    }
}

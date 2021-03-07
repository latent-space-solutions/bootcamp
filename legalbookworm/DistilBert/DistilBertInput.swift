import CoreML

struct DistilBertInput {
    // There are 2 sentinel tokens before the document, 1 [CLS] token and 1 [SEP] token.
    static private let documentTokenOverhead = 2
    
    // There are 3 sentinel tokens total, 1 [CLS] token and 2 [SEP] tokens.
    static private let totalTokenOverhead = 3
    
    var modelInput: distilbert_qaInput?
    
    let question: TokenizedString
    let document: TokenizedString
    var documentTokens: [Substring] {
        get {
            return document.tokens
        }
    }
    let start: Int
    let stop: Int
    
    private let documentOffset: Int
    
    var documentRange: Range<Int> {
        return documentOffset..<documentOffset + (stop - start + 1)
    }
    
    init(document: TokenizedString, question: TokenizedString, start: Int, stop: Int) {
        self.document = document
        self.question = question
        self.start = start
        self.stop = stop
        
        documentOffset = DistilBertInput.documentTokenOverhead + question.tokens.count
        
        var wordIDs = [Vocabulary.classifyStartTokenID]
        
        
        wordIDs += question.tokenIDs
        wordIDs += [Vocabulary.separatorTokenID]
        
        
        wordIDs += document.tokenIDs[start...stop]
        wordIDs += [Vocabulary.separatorTokenID]
        
        
        let inputArray = try? MLMultiArray(shape: [1, wordIDs.count as NSNumber], dataType: MLMultiArrayDataType.int32)
        
        
        for i in 0..<wordIDs.count {
            inputArray?[i] = NSNumber(value: wordIDs[i])
        }
        
        
        guard let tokenIDInput = inputArray else {
            fatalError("Couldn't create wordID MLMultiArray input")
        }
        
        
        let modelInput = distilbert_qaInput(input: tokenIDInput)
        self.modelInput = modelInput
    }
}

import CoreML

struct DistilBertInput {
    var modelInput: distilbert_qaInput?
    
    
    init(document: TokenizedString, question: TokenizedString, start: Int, stop: Int) {
        // the document may be larger than we can handle in one call to our model
        // start and stop are pointers that define which tokens we use as input to our model
        
        
        // TODO: Populate an MLMultiArray storing the token IDs of our question
    }
}

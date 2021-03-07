import CoreML

class DistilBert {
    var distilBertModel: distilbert_qa {
        do {
            return try distilbert_qa(configuration: .init())
        } catch {
            fatalError("Couldn't load BERT model due to: \(error.localizedDescription)")
        }
    }
    
    func findAnswer(for question: String, in document: String) -> String {
        let maxModel = 512
        // TODO: tokenize document
        // TODO: tokenize question
        
        // TODO: set start to 0
        // TODO: set stop to min(count of document -1, maxModel-1)
        
        
        // create a bert input
        // use prediciton on distilbert model
        // use Distilbert Output to find best logit combination
        // return the best logit answer
        
        return "Dr. Soong"
        
    }
}

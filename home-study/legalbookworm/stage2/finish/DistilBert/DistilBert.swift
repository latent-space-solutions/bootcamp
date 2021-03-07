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
        // tokenize document
        // tokenize question
        // set start to 0
        // set stop to min(count of document -1, maxModel-1)
        // create a bert input
        // use prediciton on distilbert model
        // use DistilBert Output to find best logit combination
        // return the best logit answer
        
        let maxModel = 512
        
        let tokenizedDocument = TokenizedString(document)
        let tokenizedQuestion = TokenizedString(question)
        
        let start = 0
        let stop = min(tokenizedDocument.tokenIDs.count - 1, maxModel - 1)
        
        let input = DistilBertInput(document: tokenizedDocument, question: tokenizedQuestion, start: start, stop: stop)
        var answer = ""
        
        do {
            let modelInput = input.modelInput!
            let prediction = try self.distilBertModel.prediction(input: modelInput)
            let best = self.bestLogitsIndices(from: prediction, in: input.documentRange)!
            let documentTokens = tokenizedDocument.tokens
            let answerStart = documentTokens[best.start + input.start].startIndex
            let answerEnd = documentTokens[best.end + input.start].endIndex
            answer = String(document[answerStart..<answerEnd])
        } catch {
            print("I couldn't run bert model.")
        }
        
        return answer
    }
}

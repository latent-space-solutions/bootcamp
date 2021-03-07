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
        // use Distilbert Output to find best logit combination
        // return the best logit answer
        let maxModel = 512
        
        let tokenizedDocument = TokenizedString(document)
        let tokenizedQuestion = TokenizedString(question)
        
        // 1. Split document tokens in chunks of 512 tokens and create DisilBertInputs for each
        // Exampe if there are 1300 elements in tokenizedDocument, split the document in three DistilBertInputs, the first and second each have 512 toksens and the last has 276 tokens
        // tip: look up stride
        let start = 0
        let stop = min(tokenizedDocument.tokenIDs.count - 1, maxModel - 1)
        
        let input = DistilBertInput(document: tokenizedDocument, question: tokenizedQuestion, start: start, stop: stop)
        var answer = ""
        
        
        // 2. TODO: Create a Dispatch Group
        
        
        // this will hold the possible answers
        var answers = [(score: Float, answer: String)]()
        
        // 3. iterate through each input
        
        // For each input
        // enter the group
        // dispatch the task on the utility queue
        // defer leave the dispatch group
        // run the same code as before but save the answer in the answers variable
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
        
        // 4. wait for the tasks to finish
        
        // 5. Sort answers by score and get the best one, return it
        return answer
    }
}

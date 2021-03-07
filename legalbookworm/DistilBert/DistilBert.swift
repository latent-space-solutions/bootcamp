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
        
        let paragraphs = document.split(separator: "\n").map {$0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .filter {$0.count > 42} 
        let tokenizedQuestion = TokenizedString(question)
        
        // 1. Split document tokens in chunks of 512 tokens and create DisilBertInputs for each
        // Exampe if there are 1300 elements in tokenizedDocument, split the document in three DistilBertInputs, the first and second each have 512 toksens and the last has 276 tokens
        // tip: look up stride
        
        let inputs = paragraphs.map { paragraph -> DistilBertInput in
            
            let tokenizedDocument = TokenizedString(String(paragraph))
            let bertInput = DistilBertInput(document: tokenizedDocument, question: tokenizedQuestion, start: 0, stop: tokenizedDocument.tokens.count - 1)
            return bertInput
        }
        
        
        // 2. Create a Dispatch Group
        let tasks = DispatchGroup()
        
        // this will hold the possible answers
        var answers = [(score: Float, answer: String)]()
        
        // 3. iterate through each input
        
        // For each input
        // enter the group
        // dispatch the task on the utility queue
        // defer leave the dispatch group
        // run the same code as before but save the answer in the answers variable
        
        for input in inputs {
            tasks.enter()
            
            DispatchQueue.global(qos: .utility).async {
                defer {tasks.leave()}
                do {
                    let modelInput = input.modelInput!
                    let prediction = try self.distilBertModel.prediction(input: modelInput)
                    let best = self.bestLogitsIndices(from: prediction, in: input.documentRange)!
                    let documentTokens = input.document.tokens
                    
                    let answerStart = documentTokens[best.start + input.start].startIndex
                    let answerEnd = documentTokens[best.end + input.start].endIndex
                    let answer = String(input.document.original[answerStart..<answerEnd])
                    let answerTuple =  (score: best.bestSum,  answer: answer)
                    answers.append(answerTuple)
                } catch {
                    print("I couldn't run bert model.")
                }
            }}
        
        // 4. wait for the tasks to finish
        tasks.wait()
        
        // 5. Sort answers by score and get the best one, return it
        guard let answer = answers.sorted(by: {$0.score > $1.score}).first else {
            return "Can't find any answer."
        }
        
        let answersUnpacked = answers.sorted(by: {$0.score > $1.score}).map({$0.answer}).joined(separator: " / ")
        
        
        //        return answer.answer
        return answersUnpacked
    }
}

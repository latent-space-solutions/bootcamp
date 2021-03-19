/*
 See LICENSE folder for this sample’s licensing information.
 
 Abstract:
 Helper type for BERTInput.swift that converts a string into tokens and their IDs.
 */

import NaturalLanguage

struct TokenizedString {
    private let _tokens: [Substring]
    private let _tokenIDs: [Int]
    
    let original: Substring
    public var tokens: [Substring] { return _tokens }
    public var tokenIDs: [Int] { return _tokenIDs }
    
    init(_ string: Substring) {
        original = string
        
        let result = TokenizedString.tokenize(string)
        _tokens = result.tokens
        _tokenIDs = result.tokenIDs
    }
    
    private static func tokenize(_ string: Substring) -> (tokens: [Substring], tokenIDs: [Int]) {
        let tokens = wordTokens(from: string)
        return wordpieceTokens(from: tokens)
    }
    
    
    public static func wordTokens(from rawString: Substring) -> [Substring] {
        // Create Word Tokens
        // Given a string, replace new lines with spaces and split on spaces
        //let wordTokens = rawString.replacingOccurrences(of: "\n", with: " ").split(separator: " ")
        let wordTokens = rawString.split(whereSeparator: {[" ", "\n"].contains($0)})
        return wordTokens
    }
    
    
    private static func wordpieceTokens(from wordTokens: [Substring]) -> (tokens: [Substring], tokenIDs: [Int]) {
        // Example: Spiderman
        // 1 - perform a dictionary lookup until an entry was found by successively dropping the last charcter
        // 1a. look up Spiderman in the dictionary => not found
        // 1b. look up Spiderma in the dictionary => not found
        // 1c. look up Spiderm in the dictionary => not found
        // 1d. look up Spider in the dictionary => found with ID (i.e. line number - 1)  8454
        // 2. save the "Spider" as a token and it's corresponding ID 8454
        // 3. get the rest of the string: "man"
        // 4. prepend "##" -> "##man" to indicate it is suffix of a string, so that the AI knows it's not a new word but a wordpiece belonging to the previous wordpiece
        // 5. perform another dictionary lookup as in 1
        // 5a. look up "##man" => found with ID 1399
        // 6. Save the "##man" as a token and it's coresponding ID 8454
        // 6. continue with more wordpieces if there's anything from the string left, otherwise -> DONE
        // 7. Nothing left in Spiderman string, so we are done
        
        // Excercise: try and figure out the word pieces and token ids for "Peter Parker" 
        
        var wordpieceTokens = [Substring]()
        var wordpieceTokenIDs = [Int]()
        
        for token in wordTokens {
            guard token.count <= 100 else {
                wordpieceTokens.append(token)
                wordpieceTokenIDs.append(Vocabulary.unkownTokenID)
                continue
            }
            
            var subTokens = [Substring]()
            var subTokenIDs = [Int]()
            
            var subToken = token
            var foundFirstSubtoken = false
            
            while !subToken.isEmpty {
                let prefix = foundFirstSubtoken ? "##" : ""
                let searchTerm = Substring(prefix + subToken)
                
                let subTokenID = Vocabulary.tokenID(of: searchTerm)
                
                if subTokenID == Vocabulary.unkownTokenID {
                    let nextSubtoken = subToken.dropLast()
                    
                    if nextSubtoken.isEmpty {
                        subTokens = [token]
                        subTokenIDs = [Vocabulary.unkownTokenID]
                        
                        break
                    }
                    
                    subToken = nextSubtoken
                } else {
                    foundFirstSubtoken = true
                    
                    subTokens.append(subToken)
                    subTokenIDs.append(subTokenID)
                    
                    subToken = token.suffix(from: subToken.endIndex)
                }
            }
            wordpieceTokens += subTokens
            wordpieceTokenIDs += subTokenIDs
        }
        
        guard wordpieceTokens.count == wordpieceTokenIDs.count else {
            fatalError("Tokens array and TokenIDs arrays must be the same size.")
        }
        
        return (wordpieceTokens, wordpieceTokenIDs)
    }
}

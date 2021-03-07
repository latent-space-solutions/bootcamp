/*
 See LICENSE folder for this sample’s licensing information.
 
 Abstract:
 Helper type for BERTInput.swift that converts a string into tokens and their IDs.
 */

import NaturalLanguage

struct TokenizedString {
    private let _tokens: [Substring]
    private let _tokenIDs: [Int]
    
    let original: String
    public var tokens: [Substring] { return _tokens }
    public var tokenIDs: [Int] { return _tokenIDs }
    
    init(_ string: String) {
        original = string
        
        let result = TokenizedString.tokenize(string)
        _tokens = result.tokens
        _tokenIDs = result.tokenIDs
    }
    
    private static func tokenize(_ string: String) -> (tokens: [Substring], tokenIDs: [Int]) {
        let tokens = wordTokens(from: string)
        return wordpieceTokens(from: tokens)
    }
    
    
    private static func wordTokens(from rawString: String) -> [Substring] {
        let wordTokens = rawString.replacingOccurrences(of: "\n", with: " ").split(separator: " ")
        
        return wordTokens
    }
    
    
    private static func wordpieceTokens(from wordTokens: [Substring]) -> (tokens: [Substring], tokenIDs: [Int]) {
        // TODO: Example: Spiderman
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
        
        // iterate through all word tokens
        // 
        
        return (wordpieceTokens, wordpieceTokenIDs)
    }
}

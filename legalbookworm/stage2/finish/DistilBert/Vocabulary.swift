/*
 See LICENSE folder for this sample’s licensing information.
 
 Abstract:
 Abstracts the BERT vocabulary setup to two tokenID methods and four constants.
 */

import Foundation

struct Vocabulary {
    // Define standard tokens - these are given by the model architecture's creators
    // ["UNK"] = 100, unkown word that cannot be constructed by word pieces - extremely rare
    // ["PAD"] = 0 , i.e. spaces
    // ["SEP"] = 102, token to seperate the question from the context
    // ["CLS"] = 101, start token to indicate the task
    // let's look them up in the dictionary and save them
    static let unkownTokenID = lookupDictionary["[UNK]"]!         // 100
    static let paddingTokenID = lookupDictionary["[PAD]"]!        // 0
    static let separatorTokenID = lookupDictionary["[SEP]"]!      // 102
    static let classifyStartTokenID = lookupDictionary["[CLS]"]!  // 101
    
    private init() { }
    private static let lookupDictionary = loadVocabulary()
    
    
    private static func loadVocabulary() -> [Substring: Int] {
        // load "vocab-distilbert.txt" from bundle
        // each line in the file is a key for the dictonary
        // the line number (starting with 0) is the value (token ID) for the dictionary
        
        let fileName = "vocab-distilbert"
        
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "txt") else {
            fatalError("Vocabulary file is missing")
        }
        
        guard let rawVocabulary = try? String(contentsOf: url) else {
            fatalError("Vocabulary file has no contents.")
        }
        
        let words = rawVocabulary.split(separator: "\n")
        let values = 0..<words.count
        let vocabulary = Dictionary(uniqueKeysWithValues: zip(words, values))
        return vocabulary
    }
    
    static func tokenID(of token: Substring) -> Int {
        // lookup token in dictionary
        // return token id if found otherwise unkown token
        let unkownTokenID = Vocabulary.unkownTokenID
        return Vocabulary.lookupDictionary[token] ?? unkownTokenID
    }
    
    
    static func tokenID(of string: String) -> Int {
        let token = Substring(string)
        return tokenID(of: token)
    }
    
    
    
}

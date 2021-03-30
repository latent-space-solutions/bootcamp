/*
 See LICENSE folder for this sample’s licensing information.
 
 Abstract:
 Abstracts the BERT vocabulary setup to two tokenID methods and four constants.
 */

import Foundation

struct Vocabulary {
    // define standard tokens
    // ["UNK"] = 100, unkown word that cannot be constructed by word pieces - extremely rare
    // ["PAD"] = 0 , i.e. spaces
    // ["SEP"] = 102, token to seperate the question from the context
    // ["CLS"] = 101, start token to indicate the task
    // let's look them up in the dictionary and save them
    
    private init() { }
    private static let lookupDictionary = loadVocabulary()
    
    
    private static func loadVocabulary() -> [Substring: Int] {
        // load "vocab-distilbert.txt" from bundle
        // each line in the file is a key for the dictonary
        // the line number (starting with 0) is the value (token ID) for the dictionary
        return [Substring: Int]()
    }
    
    static func tokenID(of token: Substring) -> Int {
        // lookup token in dictionary
        // return token id if found otherwise unkown token
        return 42
    }
    
    
    static func tokenID(of string: String) -> Int {
        let token = Substring(string)
        return tokenID(of: token)
    }
    
    
    
}

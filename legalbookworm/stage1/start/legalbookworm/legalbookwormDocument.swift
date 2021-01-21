//
//  legalbookwormDocument.swift
//  legalbookworm
//
//  Created by Stefan Zapf on 17.01.21.
//


import SwiftUI
import UniformTypeIdentifiers


// When do we need this extension?
extension UTType {
    static var exampleText: UTType {
        UTType(importedAs: "com.example.plain-text")
    }
}


// 1. TODO: refactor the class and call it PDF
struct legalbookwormDocument: FileDocument {
    var text: String
    
    
    // 2. figure out which UTType to use
    // Do we need a custom type?
    // Tip: Option Click UTType - Developer Doc - System Declared Types
    static var readableContentTypes: [UTType] { [.pdf] }
    
    // 3. Define three error types
    // a - file corrupted
    // b - file is not a valid pdf
    // c - file is a pdf but has only images
    
    init(configuration: ReadConfiguration) throws {
        // 4. Read the pdf
        guard let data = configuration.file.regularFileContents,
              let string = String(data: data, encoding: .utf8)
        else {
            throw CocoaError(.fileReadCorruptFile)
        }
        // TODO: Save the PDF document in an attribute named 'pdf'
        // TODO: Save the text from the PDF document in a attribute names 'text'
        self.text = string
    }
    
    // 5. We don't have a write functionality, so omit it 
    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        let data = text.data(using: .utf8)!
        return .init(regularFileWithContents: data)
    }
    
    
    // 6. We don't need an init for testing, we will load a sample pdf to make sure things are fine
    init(text: String = "Hello, world!") {
        self.text = text
    }
}

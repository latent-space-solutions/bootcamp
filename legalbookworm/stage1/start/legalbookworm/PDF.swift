//
//  legalbookwormDocument.swift
//  legalbookworm
//
//  Created by Stefan Zapf on 17.01.21.
//


import SwiftUI
import UniformTypeIdentifiers
import PDFKit

// When do we need this extension?
extension UTType {
    static var exampleText: UTType {
        UTType(importedAs: "com.example.plain-text")
    }
}


// 1. TODO: refactor the class and call it PDF
struct PDF: FileDocument {
    var text: String
    var pdf: PDFDocument
    
    
    // 2. figure out which UTType to use
    // Do we need a custom type?
    // Tip: Option Click UTType - Developer Doc - System Declared Types
    static var readableContentTypes: [UTType] { [ .pdf] }
    
    // 3. Define three error types
    // a - file corrupted
    // b - file is not a valid pdf
    // c - file is a pdf but has only images
    
    init(configuration: ReadConfiguration) throws {
        
        guard let data = configuration.file.regularFileContents else {
            throw fatalError("We can't read the file")
        }
        
        guard let pdf = PDFDocument(data: data) else {
            throw fatalError("We need a pdf")
        }
        
        self.pdf = pdf
        
        guard let text = pdf.string else {
            throw fatalError("We need a text-based pdf.")
        }
        
        self.text = text
    }
    
    // 5. We don't have a write functionality, so omit it 
    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        FileWrapper()
    }

}

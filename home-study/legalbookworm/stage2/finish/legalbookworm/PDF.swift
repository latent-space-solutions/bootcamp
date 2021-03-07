//
//  PdfDocument.swift
//  legalbookworm (iOS)
//
//  Created by Stefan Zapf on 12.12.20.
//

import SwiftUI
import PDFKit
import UniformTypeIdentifiers




struct PDF : FileDocument {
    let pdf: PDFDocument
    let text: String
    
    // create Custom Errors
    // 1. File can't be opened
    // 2. File is not a pdf
    // 3. File is an image-only pdf
    enum PDFError : Error {
        case couldNotOpenFile
        case fileIsNotAValidPdf
        case pdfHasNoText
    }
    
    static var readableContentTypes: [UTType] {
        [.pdf]
    }
    
    init(configuration: ReadConfiguration) throws {
        guard let data = configuration.file.regularFileContents else {
            throw PDFError.couldNotOpenFile
        }
        
        guard let pdf = PDFDocument(data: data) else {
            throw PDFError.fileIsNotAValidPdf
        }
        self.pdf = pdf
        
        guard let text = pdf.string  else {
            throw PDFError.pdfHasNoText
        }
        self.text = text
        
    }
    
    
    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        FileWrapper()
    }
    
}

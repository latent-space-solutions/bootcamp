//
//  PDFViewRepresentable.swift
//  legalbookworm (iOS)
//
//  Created by Stefan Zapf on 09.12.20.
//


import SwiftUI
import PDFKit
import UIKit

struct PDFViewRepresentable: UIViewRepresentable {
    // 1. add binding to pdf document
    // 3. add binding to selected text
    func makeUIView(context: Context) -> PDFView {
        return PDFView()
    }
    
    func updateUIView(_ pdfView: PDFView, context: Context) {
        // 2. update the document on pdf view
        // 4. add selected text as pdf annotation
        
        // use findString on document to find the place of annotion
        // get first selection
        // get page of selection
        // create a PDFAnnotation
        // add annotation to extracted page
        // pdfview go to selection
        // scrooSelectionToVisible (nil)
    }
    

}

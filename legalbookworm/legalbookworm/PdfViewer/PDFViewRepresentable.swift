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
    @Binding var document: PDFDocument
    @Binding var selectedText: String
    
    func makeUIView(context: Context) -> PDFView {
        return PDFView()
    }
    
    func updateUIView(_ pdfView: PDFView, context: Context) {
        pdfView.document = document
        let selectionOptional = pdfView.document?.findString(selectedText, withOptions: .caseInsensitive)
        guard let selection = selectionOptional else {
            return
        }
        guard let currentSelection = selection.first else {
            return
        }
        
        guard let page = currentSelection.pages.first else {
            return
        }
        
        let highlight = PDFAnnotation(bounds: currentSelection.bounds(for: page), forType: .highlight, withProperties: nil)
        highlight.color = .yellow
        page.addAnnotation(highlight)
        pdfView.currentSelection = currentSelection
        pdfView.go(to: currentSelection)
        pdfView.scrollSelectionToVisible(nil)

    }
    

}

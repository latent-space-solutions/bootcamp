//
//  PdfViewer.swift
//  legalbookworm
//
//  Created by Stefan Zapf on 10.12.20.
//

import SwiftUI
import PDFKit

struct PdfViewer: View {
    @Binding var document: PDFDocument
    @Binding var selectedText: String
    
    var body: some View {
        PDFViewRepresentable(document: $document, selectedText: $selectedText)
    }
}


struct PdfViewer_Previews: PreviewProvider {
    static var previews: some View {
        let pdf = PDFDocument(url: Bundle.main.url(forResource: "The Measure of A Property Challenge | The Legal Geeks", withExtension: "pdf")!)!
        
        PdfViewer(document: Binding.constant(pdf), selectedText: Binding.constant("Property"))
    }
}

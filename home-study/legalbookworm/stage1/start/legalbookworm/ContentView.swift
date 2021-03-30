//
//  ContentView.swift
//  legalbookworm
//
//  Created by Stefan Zapf on 17.01.21.
//

import SwiftUI
import PDFKit

struct ContentView: View {
    // 1. instead of the whole document, let's save both text and pdf document seperately
    @Binding var pdf: PDFDocument
    @Binding var text: String
    
    
    // 2. TODO Define a question attribute for the question, want answered from the pdf
    // 3. TODO Define an answer attribute for the answer from the pdf text
    var body: some View {
        // 6. Create a scrollable text view on top
        // 7. create an editable question text on the left bottom
        // 8. Create an answer text field in the center right
        // 9. Create a button to supply a dummy answer on the bottom right
        TextEditor(text: $document.text)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        // 4. load the sample pdf "The Measure of A Property Challenge | The Legal Geeks.pdf"
        // 5. supply the appropiate attributes to the view
        ContentView(document: .constant(PDF()))
    }
}

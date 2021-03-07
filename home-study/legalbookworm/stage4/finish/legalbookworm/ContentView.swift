//
//  ContentView.swift
//  Shared
//
//  Created by Stefan Zapf on 09.12.20.
//

import SwiftUI
import PDFKit

struct ContentView: View {
    @State var question: String = "Who built Data?"
    @State var answer: String = ""
    @State var pdf: PDFDocument
    @State var text: String
    // let's add distilbert globally
    let distilbert = DistilBert()
    
    var body: some View {
        VStack {
            
            PdfViewer(document: $pdf, selectedText: $answer)
            
            HStack {
                TextEditor(text: $question).padding(15)
                Text(answer).padding(15).foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                Button(action: {
                    answerQuestion()
                }, label: {
                    Text("Answer Question")
                }).padding(50).background(Color.blue).foregroundColor(.white)
            }.frame(minWidth: 500, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: 20, maxHeight: 150, alignment: .leading)
            
        }
    }
    
    func answerQuestion() -> Void {
        answer = "Analyzing"
        DispatchQueue.global(qos: .utility).async {
            let theAnswer = distilbert.findAnswer(for: question, in: text)
            
            DispatchQueue.main.async {
                let stringAnswer = String(theAnswer)
                answer = stringAnswer
            }
            
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let pdf = PDFDocument(url: Bundle.main.url(forResource: "The Measure of A Property Challenge | The Legal Geeks", withExtension: "pdf")!)!
        let text = pdf.string!
        ContentView(pdf: pdf, text: text)
    }
}

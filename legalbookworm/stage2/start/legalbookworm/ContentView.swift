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
    
    var body: some View {
        VStack {
            HStack {
                ScrollView{
                    // replace Text by Texteditor for testing
                    Text(text)
                        .frame(minWidth: 150, minHeight: 20, maxHeight: .infinity, alignment: .leading)
                }
                
            }
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
        // replace answer by call to DistilBert
        // send it to a seperate thread so, we don't block the ui
        answer = "Here is the answer to your question."
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let pdf = PDFDocument(url: Bundle.main.url(forResource: "The Measure of A Property Challenge | The Legal Geeks", withExtension: "pdf")!)!
        let text = pdf.string!
        ContentView(pdf: pdf, text: text)
    }
}

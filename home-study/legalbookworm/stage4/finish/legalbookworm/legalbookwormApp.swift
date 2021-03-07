//
//  legalbookwormApp.swift
//  Shared
//
//  Created by Stefan Zapf on 09.12.20.
//

import SwiftUI

@main
struct legalbookwormApp: App {
    var body: some Scene {
        DocumentGroup(viewing: PDF.self) { file in
            ContentView(pdf: file.document.pdf, text: file.document.text)
        }
    }
}

// This is the main starting point of our App.

import SwiftUI

@main
struct legalbookwormApp: App {
    var body: some Scene {
        DocumentGroup(viewing: PDF.self) { file in
            ContentView(pdf: file.document.pdf, text: file.document.text)
        }
    }
}

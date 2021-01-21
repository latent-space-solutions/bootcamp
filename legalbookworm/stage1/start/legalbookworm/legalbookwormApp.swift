// This is the main starting point of our App.

import SwiftUI

@main
struct legalbookwormApp: App {
    // bonus: lookup app, scene & window/document group
    var body: some Scene {
        DocumentGroup(newDocument: legalbookwormDocument()) { file in
            // 1. supply the appropriate attributes from the PDF to the ContentView
            ContentView(document: file.$document)
        }
    }
}

// 2. Add Cataclyst Mac Support
// 3. Replace custom document type by pdf 
// 4. add com.adobe.pdf as imported document type

// This is the main starting point of our App.

import SwiftUI

@main
struct legalbookwormApp: App {
    // bonus: lookup app, scene & window/document group

        var body: some Scene {
            DocumentGroup(viewing: PDF.self) { file in
                ContentView(pdf: file.document.pdf, text: file.document.text)
            }
        }

}

// 2. Add Cataclyst Mac Support
// 3. Replace custom document type by pdf 
// 4. add com.adobe.pdf as imported document type

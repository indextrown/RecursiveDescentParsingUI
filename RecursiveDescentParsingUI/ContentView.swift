//
//  ContentView.swift
//  RecursiveDescentParsingUI
//
//  Created by 김동현 on 5/9/25.
//

import SwiftUI

struct ContentView: View {
    let markdown: String = """
# 제목
### 소제목
- 항목 1
- 항목 **강조됨**
문단에는 일반 텍스트와 **굵은 텍스트**가 섞여 있습니다.

```swift
print("Hello, world!")
```

안녕하세요 ##밑줄##입니다.
"""
    var body: some View {
        VStack {
            MarkdownView(markdown: markdown)
        }
        .padding()

    }
}

#Preview {
    ContentView()
}


//        .onAppear {
//            let start = CFAbsoluteTimeGetCurrent()
//            let nodes = MarkdownParser(markdown: markdown).parseDocument()
//            let duration = CFAbsoluteTimeGetCurrent() - start
//            print("Parsing took \(duration) seconds")
//        }

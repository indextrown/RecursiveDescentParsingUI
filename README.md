# 📝 Markdown Parser (Recursive Descent)

Swift로 구현한 재귀 하강 방식의 마크다운 파서입니다.  
헤딩, 리스트, 문단, 코드블록 등 기본 마크다운 문법을 지원하며,  
**재귀적으로 인라인 파싱**하여 굵게(`**`), 밑줄(`##`) 등도 표현 가능합니다.

## ✅ Features

- [x] `#` ~ `######` 헤딩 지원
- [x] `-` 리스트 항목
- [x] 일반 문단
- [x] 코드 블록 (```swift 등)
- [x] **굵은 텍스트**
- [x] ##밑줄 텍스트##
- [x] 줄바꿈 `\n` 처리 (빈 줄 → `.lineBreak` 블록 노드 처리)

## 🧠 Parsing Logic

### Top-down 구조 (Block Level)

```text
parseDocument()
 ├─ parseBlock()
 │   ├─ parseHeading()
 │   ├─ parseCodeBlock()
 │   ├─ parseListItem()
 │   ├─ parseParagraph()
 │   └─ LineBreak 처리 (빈 줄)
 └─ advance()
```

### EBNF 문법

```ebnf
Document        ::= Block { Block }
Block           ::= Heading | ListItem | Paragraph | CodeBlock | LineBreak
Heading         ::= HeadingMarker Space TextLine
HeadingMarker   ::= '#' { '#' }
ListItem        ::= '- ' TextLine
Paragraph       ::= TextLine
CodeBlock       ::= '```' [Language] LineBreak { TextLine } '```'
LineBreak       ::= '\n'
TextLine        ::= { Inline } LineBreak
Inline          ::= Bold | Underline | Text
Bold            ::= '**' Inline+ '**'
Underline       ::= '##' Inline+ '##'
Text            ::= { Character but not '**' or '##' }
```

## 📦 Code Structure

```swift
struct MarkdownView // 전체 마크다운 뷰
struct MarkdownRenderer // Node를 SwiftUI 뷰로 변환

class MarkdownParser // 블록 레벨 파서
class InlineParser   // 인라인 파서 (재귀)

enum MarkdownNode {
    case heading(level: Int, text: String)
    case listItem(text: [InlineNode])
    case paragraph(inlines: [InlineNode])
    case code(language: String, content: String)
    case lineBreak // ← 줄바꿈도 노드로 처리
}
```

## 🛠️ Usage

```swift
let markdown: String = """
# 제목
문단입니다 **강조**와 ##밑줄##을 포함합니다.

```swift
print("Hello, world!")
```

"""

MarkdownView(markdown: markdown)

```
SwiftUI 뷰에 `MarkdownView(markdown:)`를 주입하면 렌더링됩니다.

## 🤝 Contribution

1. Fork 후 새로운 브랜치 생성
2. 기능 추가 / 버그 수정
3. Pull Request 생성  
   - 커밋 메시지는 명확하게
   - 가능하다면 테스트 코드 포함
4. 리뷰 후 Merge

> 구조 개선, 렌더링 스타일 개선, 추가 마크다운 문법 제안 환영합니다!

---

## ✨ Motivation

재귀 하강 파싱(Recursive Descent Parsing) 원리를 직접 구현하며 문법 구조의 해석 과정을 시각적으로 표현하고자 했습니다. 파싱 구조와 EBNF 문법을 직접 설계하여 확장성과 가독성을 높였습니다.

## 📄 License

MIT License
```

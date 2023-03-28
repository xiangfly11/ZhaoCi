#if os(iOS)
  import SnapshotTesting
  import SwiftUI
  import XCTest

  import MarkdownUI

  final class MarkdownTests: XCTestCase {
    private let layout = SwiftUISnapshotLayout.device(config: .iPhone8)

    func testBlockquote() {
      let view = Markdown {
        #"""
        If you'd like to quote someone, use the > character before the line.
        Blockquotes can be nested, and can also contain other formatting.

        > “Well, art is art, isn't it? Still,
        > on the other hand, water is water!
        > And east is east and west is west and
        > if you take cranberries and stew them
        > like applesauce they taste much more
        > like prunes than rhubarb does. Now,
        > uh... now you tell me what you
        > know.”
        > > “I sent the club a wire stating,
        > > **PLEASE ACCEPT MY RESIGNATION. I DON'T
        > > WANT TO BELONG TO ANY CLUB THAT WILL ACCEPT ME AS A MEMBER**.”
        > > > “Outside of a dog, a book is man's best friend. Inside of a
        > > > dog it's too dark to read.”

        ― Groucho Marx
        """#
      }
      .border(Color.accentColor)
      .padding()

      assertSnapshot(matching: view, as: .image(layout: layout))
    }

    func testCodeBlock() {
      let view = Markdown {
        #"""
        Use a group to collect multiple views into a single instance,
        without affecting the layout of those views. After creating a
        group, any modifier you apply to the group affects all of that
        group’s members.

        ```swift
        Group {
            Text("SwiftUI")
            Text("Combine")
            Text("Swift System")
        }
        .font(.headline)
        ```

        ― From Apple Developer Documentation
        """#
      }
      .border(Color.accentColor)
      .padding()

      assertSnapshot(matching: view, as: .image(layout: layout))
    }

    func testVerbatimHTML() {
      let view = Markdown {
        #"""
        A `Markdown` view ignores HTML blocks and renders
        them as verbatim text.

        <p>
        You can use Markdown syntax instead.
        </p>

        The same happens with <strong>HTML inlines</strong>.
        """#
      }
      .border(Color.accentColor)
      .padding()

      assertSnapshot(matching: view, as: .image(layout: layout))
    }

    func testOpenCodeBlock() {
      let view = Markdown {
        #"""
        An empty code block without a closing fence:

        ```swift
        """#
      }
      .border(Color.accentColor)
      .padding()

      assertSnapshot(matching: view, as: .image(layout: layout))
    }

    func testParagraphs() {
      let view = Markdown {
        #"""
        The sky above the port was the color of television, tuned to a dead channel.

        It was a bright cold day in April, and the clocks were striking thirteen.

        The sky above the port was the color of television, tuned to a dead channel.

        It was a bright cold day in April, and the clocks were striking thirteen.
        """#
      }
      .border(Color.accentColor)
      .padding()

      assertSnapshot(matching: view, as: .image(layout: layout))
    }

    func testCenteredParagraphs() {
      let view = Markdown {
        #"""
        The sky above the port was the color of television, tuned to a dead channel.

        It was a bright cold day in April, and the clocks were striking thirteen.

        The sky above the port was the color of television, tuned to a dead channel.

        It was a bright cold day in April, and the clocks were striking thirteen.
        """#
      }
      .border(Color.accentColor)
      .padding()
      .multilineTextAlignment(.center)

      assertSnapshot(matching: view, as: .image(layout: layout))
    }

    func testTrailingParagraphs() {
      let view = Markdown {
        #"""
        The sky above the port was the color of television, tuned to a dead channel.

        It was a bright cold day in April, and the clocks were striking thirteen.

        The sky above the port was the color of television, tuned to a dead channel.

        It was a bright cold day in April, and the clocks were striking thirteen.
        """#
      }
      .border(Color.accentColor)
      .padding()
      .multilineTextAlignment(.trailing)

      assertSnapshot(matching: view, as: .image(layout: layout))
    }

    func testSpacing() {
      let view = Markdown {
        #"""
        The sky above the port was the color of television, tuned to a dead channel.

        It was a bright cold day in April, and the clocks were striking thirteen.

        The sky above the port was the color of television, tuned to a dead channel.

        It was a bright cold day in April, and the clocks were striking thirteen.
        """#
      }
      .border(Color.accentColor)
      .padding()
      .markdownBlockStyle(\.paragraph) { label in
        label.markdownMargin(bottom: .zero)
      }

      assertSnapshot(matching: view, as: .image(layout: layout))
    }

    func testHeadings() {
      let view = Markdown {
        #"""
        # Heading 1
        The sky above the port was the color of television, tuned to a dead channel.
        ## Heading 2
        The sky above the port was the color of television, tuned to a dead channel.
        ### Heading 3
        The sky above the port was the color of television, tuned to a dead channel.
        #### Heading 4
        The sky above the port was the color of television, tuned to a dead channel.
        ##### Heading 5
        The sky above the port was the color of television, tuned to a dead channel.
        ###### Heading 6
        The sky above the port was the color of television, tuned to a dead channel.
        """#
      }
      .border(Color.accentColor)
      .padding()

      assertSnapshot(matching: view, as: .image(layout: layout))
    }

    func testThematicBreak() {
      let view = Markdown {
        #"""
        # SwiftUI

        Declare the user interface and behavior for your app
        on every platform.

        ---

        ## Overview

        SwiftUI provides views, controls, and layout structures
        for declaring your app’s user interface.

        ---

        ― From Apple Developer Documentation
        """#
      }
      .border(Color.accentColor)
      .padding()

      assertSnapshot(matching: view, as: .image(layout: layout))
    }

    func testInlines() {
      let view = Markdown {
        #"""
        **This is bold text**

        *This text is italicized*

        ~~This was mistaken text~~

        **This text is _extremely_ important**

        ***All this text is important***

        MarkdownUI is fully compliant with the [CommonMark Spec](https://spec.commonmark.org/current/).

        Visit https://github.com.

        Use `git status` to list all new or modified files that haven't yet been committed.
        """#
      }
      .border(Color.accentColor)
      .padding()

      assertSnapshot(matching: view, as: .image(layout: layout))
    }

    func testInlinesStyling() {
      let view = Markdown {
        #"""
        **This is bold text**

        *This text is italicized*

        ~~This was mistaken text~~

        **This text is _extremely_ important**

        **_All this text is important_**

        MarkdownUI is fully compliant with the [CommonMark Spec](https://spec.commonmark.org/current/).

        Visit https://github.com.

        Use `git status` to list all new or modified files that haven't yet been committed.
        """#
      }
      .border(Color.accentColor)
      .padding()
      .markdownTextStyle(\.code) {
        FontFamilyVariant(.monospaced)
        BackgroundColor(.yellow)
      }
      .markdownTextStyle(\.strong) {
        FontWeight(.heavy)
      }
      .markdownTextStyle(\.emphasis) {
        FontStyle(.italic)
        UnderlineStyle(.single)
      }
      .markdownTextStyle(\.strikethrough) {
        ForegroundColor(.primary)
        BackgroundColor(.primary)
      }
      .markdownTextStyle(\.link) {
        UnderlineStyle(.init(pattern: .dot))
      }

      assertSnapshot(matching: view, as: .image(layout: layout))
    }
  }
#endif

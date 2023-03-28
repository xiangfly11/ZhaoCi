#if os(iOS)
  import SnapshotTesting
  import SwiftUI
  import XCTest

  import MarkdownUI

  final class ThemeGitHubTests: XCTestCase {
    private let layout = SwiftUISnapshotLayout.device(config: .iPhone8)
    private let perceptualPrecision: Float = 0.97

    func testInlines() {
      let view = ThemePreview(theme: .gitHub) {
        #"""
        **This is bold text**

        *This text is italicized*

        ~~This was mistaken text~~

        **This text is _extremely_ important**

        MarkdownUI is fully compliant with the [CommonMark Spec](https://spec.commonmark.org/current/).

        Use `git status` to list all new or modified files that haven't yet been committed.
        """#
      }
      assertSnapshot(
        matching: view, as: .image(perceptualPrecision: perceptualPrecision, layout: layout)
      )
    }

    func testHeadings() {
      let view = ThemePreview(theme: .gitHub, colorScheme: .light) {
        #"""
        Paragraph.
        # Heading 1
        Paragraph.
        ## Heading 2
        Paragraph.
        ### Heading 3
        Paragraph.
        #### Heading 4
        Paragraph.
        ##### Heading 5
        Paragraph.
        ###### Heading 6
        Paragraph.
        """#
      }
      assertSnapshot(
        matching: view, as: .image(perceptualPrecision: perceptualPrecision, layout: layout)
      )
    }

    func testHeadingsColors() {
      let view = ThemePreview(theme: .gitHub) {
        #"""
        # Heading 1
        Paragraph.
        ## Heading 2
        Paragraph.
        ###### Heading 6
        Paragraph.
        """#
      }
      assertSnapshot(
        matching: view, as: .image(perceptualPrecision: perceptualPrecision, layout: layout)
      )
    }

    func testParagraph() {
      let view = ThemePreview(theme: .gitHub, colorScheme: .light) {
        #"""
        The sky above the port was the color of television, tuned to a dead channel.

        It was a bright cold day in April, and the clocks were striking thirteen.

        The sky above the port was the color of television, tuned to a dead channel.

        It was a bright cold day in April, and the clocks were striking thirteen.
        """#
      }
      assertSnapshot(
        matching: view, as: .image(perceptualPrecision: perceptualPrecision, layout: layout)
      )
    }

    func testBlockquote() {
      let view = ThemePreview(theme: .gitHub) {
        #"""
        The sky above the port was the color of television, tuned to a dead channel.

        > Outside of a dog, a book is man's best friend. Inside of a dog it's too dark to read.

        It was a bright cold day in April, and the clocks were striking thirteen.
        """#
      }
      assertSnapshot(
        matching: view, as: .image(perceptualPrecision: perceptualPrecision, layout: layout)
      )
    }

    func testCodeBlock() {
      let view = ThemePreview(theme: .gitHub) {
        #"""
        The sky above the port was the color of television, tuned to a dead channel.

        ```swift
        struct Sightseeing: Activity {
            func perform(with sloth: inout Sloth) -> Speed {
                sloth.energyLevel -= 10
                return .slow
            }
        }
        ```

        It was a bright cold day in April, and the clocks were striking thirteen.
        """#
      }
      assertSnapshot(
        matching: view, as: .image(perceptualPrecision: perceptualPrecision, layout: layout)
      )
    }

    func testTaskList() {
      let view = ThemePreview(theme: .gitHub) {
        #"""
        The sky above the port was the color of television, tuned to a dead channel.

        - [x] A finished task
        - [ ] An unfinished task
        """#
      }
      assertSnapshot(
        matching: view, as: .image(perceptualPrecision: perceptualPrecision, layout: layout)
      )
    }

    func testList() {
      let view = ThemePreview(theme: .gitHub, colorScheme: .light) {
        #"""
        The sky above the port was the color of television, tuned to a dead channel.

        * Systems
          * FFF units
          * Great Underground Empire (Zork)
          * Potrzebie
            * Equals the thickness of Mad issue 26
              * Developed by 19-year-old Donald E. Knuth

        It was a bright cold day in April, and the clocks were striking thirteen.

        10. Helmets
        1. Hoods
        1. Headbands, headscarves, wimples

        The sky above the port was the color of television, tuned to a dead channel.
        """#
      }
      assertSnapshot(
        matching: view, as: .image(perceptualPrecision: perceptualPrecision, layout: layout)
      )
    }

    func testTable() throws {
      guard #available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *) else {
        throw XCTSkip("Required API is not available for this test")
      }

      let view = ThemePreview(theme: .gitHub) {
        #"""
        Add tables of data:

        | Sloth speed  | Description                           |
        | ------------ | ------------------------------------- |
        | `slow`       | Moves slightly faster than a snail.   |
        | `medium`     | Moves at an average speed.            |
        | `fast`       | Moves faster than a hare.             |
        """#
      }
      assertSnapshot(
        matching: view, as: .image(perceptualPrecision: perceptualPrecision, layout: layout)
      )
    }

    func testThematicBreak() {
      let view = ThemePreview(theme: .gitHub) {
        #"""
        The sky above the port was the color of television, tuned to a dead channel.

        ---

        It was a bright cold day in April, and the clocks were striking thirteen.
        """#
      }
      assertSnapshot(
        matching: view, as: .image(perceptualPrecision: perceptualPrecision, layout: layout)
      )
    }
  }
#endif

<!--
 CONTRIBUTING.md

 This source file is part of the SDGMathematics open source project.
 https://github.com/SDGGiesbrecht/SDGMathematics

 Copyright ©2016–2017 Jeremy David Giesbrecht and the SDGMathematics contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 -->

<!--
 !!!!!!! !!!!!!! !!!!!!! !!!!!!! !!!!!!! !!!!!!! !!!!!!!
 THIS IS A SHARED FILE FROM THE REPOSITORY AT https://github.com/SDGGiesbrecht/SDG.
 CHANGES MUST BE MADE THERE.
 !!!!!!! !!!!!!! !!!!!!! !!!!!!! !!!!!!! !!!!!!! !!!!!!!
 -->

# Contributing to SDG Projects

Everyone is welcome to contribute to SDG projects!

## Reporting Bugs

1. Please **start by checking whether the bug has already been reported** by searching on GitHub under Issues.
    * If there is an existing issue, join the conversation and add any additional information you have.
    * Otherwise, open a new issue. Provide a clear description and as much relevant information as you can.

2. Consider submitting a pull request with a test that demonstrates the bug.

3. If you are aware of a solution, submit a pull request.

## Contributing Code

Pull requests of all kinds are welcome, whether bug fixes, new features, or documentation improvements.

To work on an SDG module, clone the repository and run `Refresh Workspace.command` in the repository root. It will set up (or update) the workspace for you, generating an Xcode project and setting up the tools used during development (documentation generation, style checking, etc).

Before submitting the pull request, ask yourself the following:

* **Is this the right module?** If your pull request involves new features, check that the module you are submitting to is really the best match. Your features my be better suited to another SDG module.
* **Does my request follow the style guides?**
    * SDG generally follows Swift’s own [API Design Guidelines](https://swift.org/documentation/api-design-guidelines/)
    * SDG has a few guidelines of its own. See [below](#StyleGuide).
* **Am I okay with the project licence?** Your pull request implies that you are the copyright owner for the code you submit and that you are giving permission for it to be licenced with the rest of the project. (See LICENSE.md in the project repository.)
* **Have I run `Validate Changes.command`?** It will help you test whether several basic requirements have been met.

## Style Guide<a name="StyleGuide"></a>

### File Header

Every source file should have licence information at the top. If you add a file, please copy and paste the header from another file in the same project to use as a template.

### Use Unicode

Clear, unambiguous Unicode representations are preferred over ASCII workarounds wherever possible. (See the [appendix](#UnicodeAppendix) for help entering such characters.)

For example:

Avoid       | Use instead                                                                          |
----------- | ------------------------------------------------------------------------------------ |
&#x22; (22) | “ and ” (201C/201D)                                                                  |
&#x27; (27) | ‘ and ’ (quotation, 2018/2019), ’ (apostrophe, 2019), ′ (prime, 2032)                |
&#x2D; (2D) | ‐ (hyphen, 2010), − (minus, 2212), — (dash, 2014), – (range, 2013), • (bullet, 2022) |
&#x5E; (5E) | x̂ (302)                                                                              |
&#x60; (60) | x̀ (300)                                                                              |
&#x7E; (7E) | x̃ (303), ∼ (operator, 203C), ⁓ (dash, 2053)                                          |

Use         | As                     | But not as a replacent for           |
----------- | ---------------------- | ------------------------------------ |
&#x21; (21) | exclamation, factorial | ¬ (not) ≠ (not equal)                |
&#x26; (26) | and                    | ∧ (conjunction)                      |
&#x2A; (2A) | footnote               | × (multiplication), • (bullet)       |
&#x2F; (2F) | slash                  | ÷ (division), ⁄ (fraction)           |
&#x3C; (3C) | less than              | ≤ (less than or equal), ‹ (quote),   |
&#x3E; (3E) | greater than           | ≥ (greater than or equal), › (quote) |
&#x7C; (7C) | absolute value         | ∨ (disjunction)                      |

Use of [compatibility characters](https://en.wikipedia.org/wiki/Unicode_compatibility_characters) is discouraged.

This section always applies to user‐facing strings and documentation. It also applies to source code as much as possible. SDG provides aliases for consistency. For example, after `import SDGLogic`, `if x ≠ y { ... }` can be used instead of `if x != y { ... }`.

This section does not apply when it would otherwise break functionality. For example, `let x = “rounded quotation marks”` does not compile, and `www.unambiguous‐hyphen.com` fails DNS look‐up.

### Appendix: Entering Unicode<a name="UnicodeAppendix"></a>

There are many ways to enter the thousands of characters not found on your keyboard. Here are several, listed from the easiest one‐time use, to the most efficient permanent set‐up:

1. Copy and paste. (⌘C and ⌘V • Ctrl + C and Ctrl + V)
2. Use a Character Viewer. ([Mac](https://support.apple.com/HT201586) • [Windows](https://support.microsoft.com/en-us/kb/315684))
3. Set up text replacement. ([Mac](https://support.apple.com/kb/PH25699) • [Windows](https://www.google.com/search?q=windows+text+replacement))
4. Edit the keyboard layout. ([Ukelele (Mac)](http://scripts.sil.org/cms/scripts/page.php?item_id=ukelele) • [Windows](https://www.google.com/search?q=windows+keyboard+editor))

An SDG project is in the works that will make the best of options 3 and 4 even more accessible on a Mac. Stay tuned!

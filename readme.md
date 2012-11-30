JBShellView
===========

This class provides a shell or command-line interface. Some features:

* Cocoa native, it's an `NSTextView` subclass
* Supports command history, so you can use up and down arrows, as you'd expect
* Supports auto-pairing for smarter text editing via `JBTextEditorProcessor`
* Supports asynchronous operations so you don't hang the interface.

Demo
----

![Alt text](https://raw.github.com/jbrennan/JBShellView/master/jbshellview@2x.png)

The demo application shows off the Shell view and lets you enter commands. The only recognized command is `search some query`, but by checking out the app you can hopefully figure out how to support different commands. It's pretty straightforward.
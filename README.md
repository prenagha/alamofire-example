
Command line XCode project example using
* swift
* [Carthage](https://github.com/Carthage/Carthage)
* [Alamofire](https://github.com/Alamofire/Alamofire)
* [swifty beaver](https://github.com/SwiftyBeaver/SwiftyBeaver)
* [Swift Command Line Project XCode Template](https://github.com/Zewo/Swift-Command-Line-Application-Template)

Had some trouble getting Alamofire to work until someone helped me on [Stack Overflow](http://stackoverflow.com/questions/35211138/alamofire-cant-get-response-closure-to-execute)

The key was that by default the response handler gets called by Alamofire on the main thread, and main.swift is already running on the main thread, so the response handler is blocked. Once I got Alamofire directed to another thread/queue it all started working.

I highly recommend Erica Sadun's [Swift Documentation Markup](http://ericasadun.com/2016/01/15/updates-to-swift-documentation-markup/) book

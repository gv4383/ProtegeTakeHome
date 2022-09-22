# Protégé Take Home Project

<center><img src="ProtegeTakeHome/Preview Content/Preview Assets.xcassets/Wireframe.imageset/Wireframe.png" alt="Wireframe" width="375" height="812"></center>

### Your task is to build a chat app that fetches and displays a list of messages

Thanks for applying to Protégé! The goal of this project is to show us how you like to build complex user interfaces from scratch. You should create abstractions that are simple, but flexible enough that they allow for different types of messages to be added in the future. For example, the app might need to support photo or video previews in the next app release.

Features your app should have:

* Display the name of the person you're chatting with in the nav bar
* Fetch and display messages from oldest to newest using the provided `MockChatAPI` class
* Support pagination for loading older messages as you scroll up
* Display a date label in the chat transcript whenever more than an hour has passed between messages
* Ability to add new messages to the chat using the keyboard

Requirements:

* The app should build and run on Xcode 13+ with no errors or warnings
* Any external dependencies should be installed using Swift Package Manager

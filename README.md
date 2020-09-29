
![Palmu Dating App](https://iili.io/21Rgg1.png)

![Platform](https://img.shields.io/badge/Platform-iOS-orange.svg)
![Languages](https://img.shields.io/badge/Language-Swift-orange.svg)

PalmuApp is a dating application created for demo purposes.

## Demo
<img src="https://media.giphy.com/media/vMQVTxdHcBBihtkaYw/giphy.gif" width="250" height="500" />

## Features

- [x] Unsplash Images API Using Pagination
- [x] Card View For Images
- [x] A dedicated screen to view liked images
- [x] URL / JSON Parameter Encoding
- [x] FireStore Integration as a backend DB to store liked images
- [x] Download Images using AlamofireImage
- [x] Network Requests using Alamofire
- [x] HTTP Response Validation

### Cool Features

- [x] Tinder Like Swipe View
- [x] Swipe Right To Like An Image
- [x] Swipe Left To Skip An Image

## Requirements

- iOS 13.0+
- Xcode 11+
- Swift 5+

## Design Pattern: Model-View-ViewModel (MVVM)
is a structural design pattern that separates objects into three distinct groups:
- #### Models 
  - hold application data. They’re usually structs or simple classes.
- #### Views 
  - display visual elements and controls on the screen. They’re typically subclasses of UIView.
- #### View models
  - transform model information into values that can be displayed on a view. They’re usually classes, so they can be passed around as references.

## Dependencies

- [Koloda](https://github.com/Yalantis/Koloda)
- [Alamofire](https://github.com/Alamofire/Alamofire)
- [AlamofireImage](https://github.com/Alamofire/AlamofireImage)
- [Firebase/Firestore](https://firebase.google.com/docs/ios/setup)
- [RxSwift](https://github.com/ReactiveX/RxSwift)
- [RxCocoa](https://github.com/ReactiveX/RxSwift)

## Installation

### CocoaPods

[CocoaPods](https://cocoapods.org) is a dependency manager for Cocoa projects. For usage and installation instructions, visit their website. To run the project:
- Open terminal
- `cd` into your top-level project directory
- Run the followinfg command: pod install

### Improvements

- [Check internet connection before making api call using reachability class](https://stackoverflow.com/questions/35427698/how-to-use-networkreachabilitymanager-in-alamofire/44300590#44300590) kindly also upvote my answer 😉
- Display a message/image if there are no photos in both screens
- Add a button to undo swipe card action (Left/Right)
- Add a snapShot listener to detect any change in Firestore DB
- Preview liked image with details in full screen
- User authentication using Firebase

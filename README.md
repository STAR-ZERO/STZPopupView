# STZPopupView

[![Version](https://img.shields.io/cocoapods/v/STZPopupView.svg?style=flat)](http://cocoadocs.org/docsets/STZPopupView) [![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/STAR-ZERO/STZPopupView)

Customizable simple popup view in iOS. Implemented as an extension of UIViewController.

![Screenshot](https://raw.githubusercontent.com/STAR-ZERO/STZPopupView/master/screenshot.gif)

## Usage

### import

```swift
import STZPopupView
```

### Show popup

in UIViewController

```swift
let popupView = UIView()
// ..setup popupView..

presentPopupView(popupView)
```

### Dismiss popup

in UIViewController

```swift
dismissPopupView()
```

### Customization

```swift
let popupConfig = STZPopupViewConfig()
popupConfig.dismissTouchBackground = false
popupConfig.cornerRadius = 10
// ...more customize

presentPopupView(popupView, config: popupConfig)
```

Customize option see [Source/STZPopupViewConfig.swift](https://github.com/STAR-ZERO/STZPopupView/blob/master/Source/STZPopupViewConfig.swift)

## Requirements

* iOS 8.0+
* Xcode 6.3.1+

## Installation

### Cocoapods

STZPopupView is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:


```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'
use_frameworks!

pod 'STZPopupView'
```

Note: need install cocoapods >= 0.36, and iOS deployment target >= 8.0

	[sudo] gem install cocoapods

### Carthage

STZPopupView can be install using the [Carthage](https://github.com/Carthage/Carthage). Add your Cartfile:

	github "STAR-ZERO/STZPopupView"

### Manually

Copy source file to project. 

* Source/STZPopupViewConfig.swift
* Source/UIViewController+STZPopupView.swift

## Author

Kenji Abe, kenji@star-zero.com

## License

STZPopupView is available under the MIT license. See the LICENSE file for more info.


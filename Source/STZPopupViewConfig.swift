//
//  STZPopupViewConfig.swift
//  STZPopupView
//
//  Created by Kenji Abe on 2015/02/22.
//  Copyright (c) 2015年 Kenji Abe. All rights reserved.
//

import UIKit

/**
Show Animation type
*/
public enum STZPopupShowAnimation {
    case None
    case FadeIn
    case SlideInFromTop
    case SlideInFromBottom
    case SlideInFromLeft
    case SlideInFromRight
    case Custom // Need implements 'showCustomAnimation'
}

/**
Dismiss Animation
*/
public enum STZPopupDismissAnimation {
    case None
    case FadeOut
    case SlideOutToTop
    case SlideOutToBottom
    case SlideOutToLeft
    case SlideOutToRight
    case Custom // Need implements 'dismissCustomAnimation'
}

/**
*  Popup Config
*/
public class STZPopupViewConfig {

    /// Dismiss touch the Background if ture.
    public var dismissTouchBackground = true

    /// Popup corner radius value.
    public var cornerRadius: CGFloat = 0

    /// Background overlay color.
    public var overlayColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)

    /// Show animation type.
    public var showAnimation = STZPopupShowAnimation.FadeIn

    /// Dismiss animation type.
    public var dismissAnimation = STZPopupDismissAnimation.FadeOut

    /// Clouser show animation is completed.
    /// Pass the popup view to argument.
    public var showCompletion: ((UIView) -> Void)? = nil

    /// Clouser disimss animation is completed.
    /// Pass the popup view to argument.
    public var dismissCompletion: ((UIView) -> Void)? = nil

    /// Show custom animation of closure.
    ///
    /// Set STZPopupShowAnimation.Custom to 'showAnimation' property to use custom animation.
    ///
    /// Argument:
    ///
    /// - containerView: Enclosing a popup view. Added to the view of UIViewController.
    /// - popupView: A popup view is displayed.
    /// - completion: Be sure to call after animation completion.
    public var showCustomAnimation: (UIView, UIView, (Void) -> Void) -> Void = { containerView, popupView, completion in }

    /// Dismiss custom animation of closure.
    ///
    /// Set STZPopupShowAnimation.Custom to 'dismissAnimation' property to use custom animation.
    ///
    /// Argument:
    ///
    /// - containerView: Enclosing a popup view. Added to the view of UIViewController.
    /// - popupView: A popup view is displayed.
    /// - completion: Be sure to call after animation completion.
    public var dismissCustomAnimation: (UIView, UIView, (Void) -> Void) -> Void = { containerView, popupView, completion in }

    public init() {}
}
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
    case none
    case fadeIn
    case slideInFromTop
    case slideInFromBottom
    case slideInFromLeft
    case slideInFromRight
    case custom // Need implements 'showCustomAnimation'
}

/**
Dismiss Animation
*/
public enum STZPopupDismissAnimation {
    case none
    case fadeOut
    case slideOutToTop
    case slideOutToBottom
    case slideOutToLeft
    case slideOutToRight
    case custom // Need implements 'dismissCustomAnimation'
}

/**
*  Popup Config
*/
open class STZPopupViewConfig {

    /// Dismiss touch the Background if ture.
    open var dismissTouchBackground = true

    /// Popup corner radius value.
    open var cornerRadius: CGFloat = 0

    /// Background overlay color.
    open var overlayColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)

    /// Background blur effect
    open var blurEffectStyle: UIBlurEffectStyle? = nil

    /// Show animation type.
    open var showAnimation = STZPopupShowAnimation.fadeIn

    /// Dismiss animation type.
    open var dismissAnimation = STZPopupDismissAnimation.fadeOut

    /// Clouser show animation is completed.
    /// Pass the popup view to argument.
    open var showCompletion: ((UIView) -> Void)? = nil

    /// Clouser disimss animation is completed.
    /// Pass the popup view to argument.
    open var dismissCompletion: ((UIView) -> Void)? = nil

    /// Show custom animation of closure.
    ///
    /// Set STZPopupShowAnimation.Custom to 'showAnimation' property to use custom animation.
    ///
    /// Argument:
    ///
    /// - containerView: Enclosing a popup view. Added to the view of UIViewController.
    /// - popupView: A popup view is displayed.
    /// - completion: Be sure to call after animation completion.
    open var showCustomAnimation: (UIView, UIView, @escaping () -> Void) -> Void = { containerView, popupView, completion in }

    /// Dismiss custom animation of closure.
    ///
    /// Set STZPopupShowAnimation.Custom to 'dismissAnimation' property to use custom animation.
    ///
    /// Argument:
    ///
    /// - containerView: Enclosing a popup view. Added to the view of UIViewController.
    /// - popupView: A popup view is displayed.
    /// - completion: Be sure to call after animation completion.
    open var dismissCustomAnimation: (UIView, UIView, @escaping () -> Void) -> Void = { containerView, popupView, completion in }

    public init() {}
}

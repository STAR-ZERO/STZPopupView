//
//  UIViewController+STZPopupView.swift
//  STZPopupView
//
//  Created by Kenji Abe on 2015/02/21.
//  Copyright (c) 2015年 Kenji Abe. All rights reserved.
//

import UIKit

/// Association key
private var containerViewAssociationKey: UInt8 = 0
private var popupViewAssociationKey: UInt8 = 0
private var configAssociationKey: UInt8 = 0

/**
*  UIViewController + STZPopupView
*/
extension UIViewController {
    
    // MARK: - Property
    
    /// Popup target view
    private var targetView: UIView {
        var viewController = self
        while let parentViewController = viewController.parentViewController {
            viewController = parentViewController
        }
        return viewController.view
    }
    
    /// Popup conteiner view
    private var containerView: UIView? {
        get {
            return objc_getAssociatedObject(self, &containerViewAssociationKey) as? UIView
        }
        set {
            objc_setAssociatedObject(self, &containerViewAssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    /// Popup view
    private var popupView: UIView? {
        get {
            return objc_getAssociatedObject(self, &popupViewAssociationKey) as? UIView
        }
        set {
            objc_setAssociatedObject(self, &popupViewAssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    /// Popup config
    private var config: STZPopupViewConfig? {
        get {
            return objc_getAssociatedObject(self, &configAssociationKey) as? STZPopupViewConfig
        }
        set {
            objc_setAssociatedObject(self, &configAssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    // MARK: - Show popup

    /**
    Show popup

    - parameter popupView: Popup view
    - parameter config:    Config (Option)
    */
    public func presentPopupView(popupView: UIView, config: STZPopupViewConfig = STZPopupViewConfig()) {

        if self.containerView != nil {
            return
        }
        
        let containerView = UIView(frame: targetView.bounds)
        
        let overlayView = UIView(frame: targetView.bounds)
        overlayView.backgroundColor = config.overlayColor
        containerView.addSubview(overlayView)
        
        let dismissButton = UIButton(frame: targetView.bounds)
        containerView.addSubview(dismissButton)
        if config.dismissTouchBackground {
            dismissButton.addTarget(self, action: Selector("dismissPopupView"), forControlEvents: UIControlEvents.TouchUpInside)
        }
        
        popupView.center = CGPointMake(targetView.frame.size.width / 2, targetView.frame.size.height / 2)
        popupView.layer.cornerRadius = config.cornerRadius
        containerView.addSubview(popupView)
        
        targetView.addSubview(containerView)
        
        self.containerView = containerView
        self.popupView = popupView
        self.config = config
        
        showAnimation()
    }

    private func showAnimation() {
        if let config = config {
            switch (config.showAnimation) {
            case .None:
                completionShowAnimation(true)
            case .FadeIn:
                fadeIn()
            case .SlideInFromTop:
                slideInFromTop()
            case .SlideInFromBottom:
                slideInFromBottom()
            case .SlideInFromLeft:
                slideInFromLeft()
            case .SlideInFromRight:
                slideInFromRight()
            case .Custom:
                if let containerView = containerView, let popupView = popupView {
                    config.showCustomAnimation(containerView, popupView, { self.completionShowAnimation(true) })
                }
            }
        }
    }

    private func completionShowAnimation(finished: Bool) {
        if let completion = config?.showCompletion, let popupView = popupView {
            completion(popupView)
        }
    }

    // MARK: - Dismiss popup

    /**
    Dismiss popup
    */
    public func dismissPopupView() {
        dismissAnimation()
    }

    private func completionDismissAnimation(finished: Bool) {
        if let completion = config?.dismissCompletion, let popupView =  popupView {
            completion(popupView)
        }

        // remove view
        containerView?.removeFromSuperview()
        containerView = nil
        config = nil
    }
    
    private func dismissAnimation() {
        if let config = config {
            switch (config.dismissAnimation) {
            case .None:
                completionDismissAnimation(true)
            case .FadeOut:
                fadeOut()
            case .SlideOutToTop:
                slideOutToTop()
            case .SlideOutToBottom:
                slideOutToBottom()
            case .SlideOutToLeft:
                slideOutToLeft()
            case .SlideOutToRight:
                slideOutToRight()
            case .Custom:
                if let containerView = containerView, let popupView = popupView {
                    config.dismissCustomAnimation(containerView, popupView, { self.completionDismissAnimation(true) })
                }
            }
        }
    }
    
    // MARK: - Show Animation
    
    private func fadeIn() {
        if let containerView = containerView {
            containerView.alpha = 0
            UIView.animateWithDuration(0.2, animations: {
                containerView.alpha = 1
            }, completion: completionShowAnimation)
        }
    }

    private func slideInFromTop() {
        if let containerView = containerView, let popupView = popupView {

            var frame = popupView.frame
            frame.origin.y = -CGRectGetHeight(frame)
            popupView.frame = frame

            UIView.animateWithDuration(0.3, animations: {
                popupView.center = containerView.center
            }, completion: completionShowAnimation)
        }
    }

    private func slideInFromBottom() {
        if let containerView = containerView, let popupView = popupView {

            var frame = popupView.frame
            frame.origin.y = CGRectGetHeight(containerView.frame)
            popupView.frame = frame

            UIView.animateWithDuration(0.3, animations: {
                popupView.center = containerView.center
            }, completion: completionShowAnimation)
        }
    }

    private func slideInFromLeft() {
        if let containerView = containerView, let popupView = popupView {

            var frame = popupView.frame
            frame.origin.x = -CGRectGetWidth(frame)
            popupView.frame = frame

            UIView.animateWithDuration(0.3, animations: {
                popupView.center = containerView.center
            }, completion: completionShowAnimation)
        }
    }

    private func slideInFromRight() {
        if let containerView = containerView, let popupView = popupView {

            var frame = popupView.frame
            frame.origin.x = CGRectGetWidth(containerView.frame)
            popupView.frame = frame

            UIView.animateWithDuration(0.3, animations: {
                popupView.center = containerView.center
            }, completion: completionShowAnimation)
        }
    }

    // MARK: - Dismiss Animation
    
    private func fadeOut() {
        if let containerView = containerView {
            UIView.animateWithDuration(0.2, animations: {
                containerView.alpha = 0
            }, completion: completionDismissAnimation)
        }
    }

    private func slideOutToTop() {
        if let _ = containerView, let popupView = popupView {
            UIView.animateWithDuration(0.3, animations: {
                var frame = popupView.frame
                frame.origin.y = -CGRectGetHeight(frame)
                popupView.frame = frame
            }, completion: completionDismissAnimation)
        }
    }

    private func slideOutToBottom() {
        if let containerView = containerView, let popupView = popupView {
            UIView.animateWithDuration(0.3, animations: {
                var frame = popupView.frame
                frame.origin.y = CGRectGetHeight(containerView.frame)
                popupView.frame = frame
            }, completion: completionDismissAnimation)
        }
    }

    private func slideOutToLeft() {
        if let _ = containerView, let popupView = popupView {
            UIView.animateWithDuration(0.3, animations: {
                var frame = popupView.frame
                frame.origin.x = -CGRectGetWidth(frame)
                popupView.frame = frame
            }, completion: completionDismissAnimation)
        }
    }

    private func slideOutToRight() {
        if let containerView = containerView, let popupView = popupView {
            UIView.animateWithDuration(0.3, animations: {
                var frame = popupView.frame
                frame.origin.x = CGRectGetWidth(containerView.frame)
                popupView.frame = frame
            }, completion: completionDismissAnimation)
        }
    }

}

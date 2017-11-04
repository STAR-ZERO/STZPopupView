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
        while let parentViewController = viewController.parent {
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
    public func presentPopupView(_ popupView: UIView, config: STZPopupViewConfig = STZPopupViewConfig()) {

        if self.containerView != nil {
            return
        }

        let containerView = UIView(frame: targetView.bounds)
        containerView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        let overlayView = UIView(frame: targetView.bounds)
        overlayView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        overlayView.backgroundColor = config.overlayColor
        containerView.addSubview(overlayView)

        // blur effect
        if let blurStyle = config.blurEffectStyle {
            let blurEffectView = UIVisualEffectView(effect: UIBlurEffect(style: blurStyle))
            blurEffectView.frame = containerView.frame;
            blurEffectView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
            containerView.addSubview(blurEffectView)
        }

        let dismissButton = UIButton(frame: targetView.bounds)
        dismissButton.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        containerView.addSubview(dismissButton)
        if config.dismissTouchBackground {
            dismissButton.addTarget(self, action: #selector(dismissPopupView), for: UIControlEvents.touchUpInside)
        }

        popupView.center = CGPoint(x: targetView.bounds.midX, y: targetView.bounds.midY)
        popupView.autoresizingMask = [.flexibleLeftMargin,
                                      .flexibleTopMargin,
                                      .flexibleRightMargin,
                                      .flexibleBottomMargin]
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
            case .none:
                completionShowAnimation(true)
            case .fadeIn:
                fadeIn()
            case .slideInFromTop:
                slideInFromTop()
            case .slideInFromBottom:
                slideInFromBottom()
            case .slideInFromLeft:
                slideInFromLeft()
            case .slideInFromRight:
                slideInFromRight()
            case .custom:
                if let containerView = containerView, let popupView = popupView {
                    config.showCustomAnimation(containerView, popupView, { self.completionShowAnimation(true) })
                }
            }
        }
    }

    private func completionShowAnimation(_ finished: Bool) {
        if let completion = config?.showCompletion, let popupView = popupView {
            completion(popupView)
        }
    }

    // MARK: - Dismiss popup

    /**
    Dismiss popup
    */
    @objc
    public func dismissPopupView() {
        dismissAnimation()
    }

    private func completionDismissAnimation(_ finished: Bool) {
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
            case .none:
                completionDismissAnimation(true)
            case .fadeOut:
                fadeOut()
            case .slideOutToTop:
                slideOutToTop()
            case .slideOutToBottom:
                slideOutToBottom()
            case .slideOutToLeft:
                slideOutToLeft()
            case .slideOutToRight:
                slideOutToRight()
            case .custom:
                if let containerView = containerView, let popupView = popupView {
                    config.dismissCustomAnimation(containerView, popupView, { self.completionDismissAnimation(true) })
                }
            }
        }
    }
    
    // MARK: - Show Animation
    
    private func fadeIn() {
        if let popupView = popupView {
            popupView.alpha = 0
            UIView.animate(withDuration: 0.2, animations: {
                popupView.alpha = 1
            }, completion: completionShowAnimation)
        }
    }

    private func slideInFromTop() {
        if let containerView = containerView, let popupView = popupView {

            var frame = popupView.frame
            frame.origin.y = -frame.height
            popupView.frame = frame

            UIView.animate(withDuration: 0.3, animations: {
                popupView.center = containerView.center
            }, completion: completionShowAnimation)
        }
    }

    private func slideInFromBottom() {
        if let containerView = containerView, let popupView = popupView {

            var frame = popupView.frame
            frame.origin.y = containerView.frame.height
            popupView.frame = frame

            UIView.animate(withDuration: 0.3, animations: {
                popupView.center = containerView.center
            }, completion: completionShowAnimation)
        }
    }

    private func slideInFromLeft() {
        if let containerView = containerView, let popupView = popupView {

            var frame = popupView.frame
            frame.origin.x = -frame.width
            popupView.frame = frame

            UIView.animate(withDuration: 0.3, animations: {
                popupView.center = containerView.center
            }, completion: completionShowAnimation)
        }
    }

    private func slideInFromRight() {
        if let containerView = containerView, let popupView = popupView {

            var frame = popupView.frame
            frame.origin.x = containerView.frame.width
            popupView.frame = frame

            UIView.animate(withDuration: 0.3, animations: {
                popupView.center = containerView.center
            }, completion: completionShowAnimation)
        }
    }

    // MARK: - Dismiss Animation
    
    private func fadeOut() {
        if let containerView = containerView {
            UIView.animate(withDuration: 0.2, animations: {
                containerView.alpha = 0
            }, completion: completionDismissAnimation)
        }
    }

    private func slideOutToTop() {
        if let _ = containerView, let popupView = popupView {
            UIView.animate(withDuration: 0.3, animations: {
                var frame = popupView.frame
                frame.origin.y = -frame.height
                popupView.frame = frame
            }, completion: completionDismissAnimation)
        }
    }

    private func slideOutToBottom() {
        if let containerView = containerView, let popupView = popupView {
            UIView.animate(withDuration: 0.3, animations: {
                var frame = popupView.frame
                frame.origin.y = containerView.frame.height
                popupView.frame = frame
            }, completion: completionDismissAnimation)
        }
    }

    private func slideOutToLeft() {
        if let _ = containerView, let popupView = popupView {
            UIView.animate(withDuration: 0.3, animations: {
                var frame = popupView.frame
                frame.origin.x = -frame.width
                popupView.frame = frame
            }, completion: completionDismissAnimation)
        }
    }

    private func slideOutToRight() {
        if let containerView = containerView, let popupView = popupView {
            UIView.animate(withDuration: 0.3, animations: {
                var frame = popupView.frame
                frame.origin.x = containerView.frame.width
                popupView.frame = frame
            }, completion: completionDismissAnimation)
        }
    }

}

//
//  ViewController.swift
//  Example
//
//  Created by Kenji Abe on 2015/02/21.
//  Copyright (c) 2015年 Kenji Abe. All rights reserved.
//

import UIKit
import STZPopupView

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func touchDefault(sender: AnyObject) {

        let popupView = createPopupview()

        presentPopupView(popupView)
    }

    @IBAction func touchCustom1(sender: AnyObject) {

        let popupView = createPopupview()

        let popupConfig = STZPopupViewConfig()
        popupConfig.dismissTouchBackground = false
        popupConfig.cornerRadius = 10
        popupConfig.overlayColor = UIColor(red: 1, green: 0, blue: 0, alpha: 1)
        popupConfig.showAnimation = .SlideInFromTop
        popupConfig.dismissAnimation = .SlideOutToBottom
        popupConfig.showCompletion = { popupView in
            println("show")
        }
        popupConfig.dismissCompletion = { popupView in
            println("dismiss")
        }

        presentPopupView(popupView, config: popupConfig)
    }

    @IBAction func touchCustom2(sender: AnyObject) {

        let popupView = createPopupview()

        let popupConfig = STZPopupViewConfig()

        // Custom animation
        popupConfig.showAnimation = .Custom
        popupConfig.dismissAnimation = .Custom
        popupConfig.showCustomAnimation = { containerView, popupView, completion in

            // initial position
            var frame = popupView.frame
            frame.origin.x = -CGRectGetWidth(frame)
            frame.origin.y = -CGRectGetHeight(frame)
            popupView.frame = frame

            UIView.animateWithDuration(0.3, animations: {
                // final position
                popupView.center = containerView.center

            }, completion: { finished in

                // Be sure to call after animation completion.
                completion()
            })
        }
        popupConfig.dismissCustomAnimation = { containerView, popupView, completion in

            UIView.animateWithDuration(0.3, animations: {

                var frame = popupView.frame
                frame.origin.x = CGRectGetWidth(containerView.frame)
                frame.origin.y = CGRectGetHeight(containerView.frame)
                popupView.frame = frame

            }, completion: { finished in

                // Be sure to call after animation completion.
                completion()
            })
        }

        presentPopupView(popupView, config: popupConfig)
    }

    func createPopupview() -> UIView {

        let popupView = UIView(frame: CGRectMake(0, 0, 200, 160))
        popupView.backgroundColor = UIColor.whiteColor()

        // Close button
        let button = UIButton.buttonWithType(.System) as UIButton
        button.frame = CGRectMake(60, 60, 80, 40)
        button.setTitle("Close", forState: UIControlState.Normal)
        button.addTarget(self, action: "touchClose", forControlEvents: UIControlEvents.TouchUpInside)
        popupView.addSubview(button)

        return popupView
    }

    func touchClose() {
        dismissPopupView()
    }
}


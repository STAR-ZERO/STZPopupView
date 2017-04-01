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

    @IBAction func touchDefault(_ sender: AnyObject) {

        let popupView = createPopupview()

        presentPopupView(popupView)
    }

    @IBAction func touchCustom1(_ sender: AnyObject) {

        let popupView = createPopupview()

        let popupConfig = STZPopupViewConfig()
        popupConfig.dismissTouchBackground = false
        popupConfig.cornerRadius = 10
        popupConfig.overlayColor = UIColor(red: 1, green: 0, blue: 0, alpha: 1)
        popupConfig.showAnimation = .slideInFromTop
        popupConfig.dismissAnimation = .slideOutToBottom
        popupConfig.showCompletion = { popupView in
            print("show")
        }
        popupConfig.dismissCompletion = { popupView in
            print("dismiss")
        }

        presentPopupView(popupView, config: popupConfig)
    }

    @IBAction func touchCustom2(_ sender: AnyObject) {

        let popupView = createPopupview()

        let popupConfig = STZPopupViewConfig()

        // Custom animation
        popupConfig.showAnimation = .custom
        popupConfig.dismissAnimation = .custom
        
        popupConfig.showCustomAnimation = { containerView, popupView, completion in

            // initial position
            var frame = popupView.frame
            frame.origin.x = -frame.width
            frame.origin.y = -frame.height
            popupView.frame = frame

            UIView.animate(withDuration: 0.3, animations: {
                // final position
                popupView.center = containerView.center

            }, completion: { finished in

                // Be sure to call after animation completion.
                completion()
            })
        }
        popupConfig.dismissCustomAnimation = { containerView, popupView, completion in

            UIView.animate(withDuration: 0.3, animations: {

                var frame = popupView.frame
                frame.origin.x = containerView.frame.width
                frame.origin.y = containerView.frame.height
                popupView.frame = frame

            }, completion: { finished in

                // Be sure to call after animation completion.
                completion()
            })
        }

        presentPopupView(popupView, config: popupConfig)
    }

    @IBAction func touchCustom3(_ sender: Any) {
        
        let popupView = createPopupview()
        
        let popupConfig = STZPopupViewConfig()
        
        popupConfig.blurEffectStyle = .light
        
        presentPopupView(popupView, config: popupConfig)
    }

    func createPopupview() -> UIView {

        let popupView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 160))
        popupView.backgroundColor = UIColor.white

        // Close button
        let button = UIButton(type: .system)
        button.frame = CGRect(x: 60, y: 60, width: 80, height: 40)
        button.setTitle("Close", for: UIControlState())
        button.addTarget(self, action: #selector(touchClose), for: UIControlEvents.touchUpInside)
        popupView.addSubview(button)

        return popupView
    }

    func touchClose() {
        dismissPopupView()
    }
}


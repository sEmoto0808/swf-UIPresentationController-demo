//
//  NextViewController.swift
//  swf-Transition-demo
//
//  Created by S.Emoto on 2018/10/07.
//  Copyright © 2018 S.Emoto. All rights reserved.
//

import UIKit

class NextViewController: UIViewController {
    
//    var interactor: Interactor!
    private var initialTouchPoint = CGPoint(x: 15, y: 15)

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // 画面を下に引っ張る
    @IBAction func didDragDown(_ sender: UIPanGestureRecognizer) {
        
        let touchPoint = sender.location(in: self.view)
        let isDragDown = touchPoint.y - initialTouchPoint.y > 0
        let isEnoughDragged = touchPoint.y - initialTouchPoint.y > 100
        
        switch sender.state {
        case .began:
            initialTouchPoint = touchPoint
            break
        case .changed:
            if isDragDown {
                UIView.animate(withDuration: 0.1, animations: {
                    self.view.frame = CGRect(x: 15,
                                             y: touchPoint.y - self.initialTouchPoint.y,
                                             width: self.view.frame.size.width,
                                             height: self.view.frame.size.height)
                })
            }
        case .ended, .cancelled:
            if isEnoughDragged {
                dismiss(animated: true, completion: nil)
            } else {
                UIView.animate(withDuration: 0.3, animations: {
                    self.view.frame = CGRect(x: 15,
                                             y: 15,
                                             width: self.view.frame.size.width,
                                             height: self.view.frame.size.height)
                })
            }
        default:
            break
        }
    }
}

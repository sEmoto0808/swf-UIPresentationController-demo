//
//  ViewController.swift
//  swf-Transition-demo
//
//  Created by S.Emoto on 2018/10/06.
//  Copyright © 2018 S.Emoto. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func didTapFade(_ sender: Any) {
        
        
        let storyboard = UIStoryboard(name: "FadeViewController", bundle: nil)
        guard let fadeVC = storyboard.instantiateInitialViewController() else { return }
        
//        fadeVC.modalTransitionStyle = .coverVertical
        fadeVC.modalTransitionStyle = .crossDissolve
//        fadeVC.modalTransitionStyle = .flipHorizontal
//        fadeVC.modalTransitionStyle = .partialCurl
        
        present(fadeVC, animated: true, completion: nil)
    }
    
    @IBAction func didTapVertical(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "VerticalViewController", bundle: nil)
        guard let verticalVC = storyboard.instantiateInitialViewController() else { return }
        
        verticalVC.modalPresentationStyle = .custom
        verticalVC.transitioningDelegate = self
        
        present(verticalVC, animated: true, completion: nil)
    }
}

// MARK: - UIViewControllerTransitioningDelegate
extension ViewController: UIViewControllerTransitioningDelegate {
    
    func presentationController(forPresented presented: UIViewController,
                                presenting: UIViewController?,
                                source: UIViewController) -> UIPresentationController? {
        
        return BottomPresentationController(presentedViewController: presented,
                                            presenting: presenting)
    }
}

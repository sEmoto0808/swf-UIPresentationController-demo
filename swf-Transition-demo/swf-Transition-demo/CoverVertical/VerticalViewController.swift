//
//  FadeViewController.swift
//  swf-Transition-demo
//
//  Created by S.Emoto on 2018/10/06.
//  Copyright © 2018 S.Emoto. All rights reserved.
//

import UIKit

class VerticalViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    @IBAction func didTapDismiss(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didTapNext(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "NextViewController", bundle: nil)
        guard let nextVC = storyboard.instantiateInitialViewController() else { return }
        
        nextVC.modalPresentationStyle = .custom
        nextVC.transitioningDelegate = self
        
        dismiss(animated: true, completion: { [presentingViewController]() -> Void in
            presentingViewController?.present(nextVC, animated: true, completion: nil)
        })
    }
    
}

// MARK: - UIViewControllerTransitioningDelegate
extension VerticalViewController: UIViewControllerTransitioningDelegate {
    
    func presentationController(forPresented presented: UIViewController,
                                presenting: UIViewController?,
                                source: UIViewController) -> UIPresentationController? {
        
        return CenterPresentationController(presentedViewController: presented,
                                            presenting: presenting)
    }
}

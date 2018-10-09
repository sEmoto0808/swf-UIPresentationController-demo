//
//  VerticalPresentationController.swift
//  swf-Transition-demo
//
//  Created by S.Emoto on 2018/10/07.
//  Copyright © 2018 S.Emoto. All rights reserved.
//

import UIKit

class BottomPresentationController: UIPresentationController {

    // 画面の上の表示するView
    private var overlayView = UIView()
    private let margin = (x: CGFloat(30), y: CGFloat(220.0))
    
    // MARK: - 表示トランジション前に呼ばれる
    override func presentationTransitionWillBegin() {
        
        guard let containerView = self.containerView else { return }
        
        // overlayViewのセットアップ
        overlayView = UIView(frame: containerView.bounds)
        overlayView.gestureRecognizers = [UITapGestureRecognizer(target: self,
                                                                 action: #selector(BottomPresentationController.overlayViewDidTouch(_:)))]
        overlayView.backgroundColor = .black
        overlayView.alpha = 0.0
        
        containerView.insertSubview(overlayView, at: 0)
        
        // トランジションを実行
        presentedViewController.transitionCoordinator?
            .animate(alongsideTransition: {[weak self] context in
                self?.overlayView.alpha = 0.7
                },
                     completion:nil)
    }
    
    // MARK: - 非表示トランジション開始前に呼ばれる
    override func dismissalTransitionWillBegin() {
        presentedViewController.transitionCoordinator?
            .animate(alongsideTransition: {[weak self] context in
                self?.overlayView.alpha = 0.0
                },
                     completion:nil)
    }
    
    // MARK: - 非表示トランジション開始後に呼ばれる
    override func dismissalTransitionDidEnd(_ completed: Bool) {
        if completed {
            overlayView.removeFromSuperview()
        }
    }
    
    // MARK: - 子のコンテナサイズを返す
    override func size(forChildContentContainer container: UIContentContainer,
                       withParentContainerSize parentSize: CGSize) -> CGSize {
        
        return CGSize(width: parentSize.width - margin.x,
                      height: parentSize.height - margin.y)
    }
    
    // MARK: - 呼び出し先のView Controllerのframeを返す
    override var frameOfPresentedViewInContainerView: CGRect {
        var presentedViewFrame = CGRect()
        let containerBounds = containerView!.bounds
        let childContentSize = size(forChildContentContainer: presentedViewController,
                                    withParentContainerSize: containerBounds.size)
        presentedViewFrame.size = childContentSize
        presentedViewFrame.origin.x = margin.x / 2.0
        presentedViewFrame.origin.y = containerBounds.size.height - childContentSize.height + 10
        
        return presentedViewFrame
    }
    
    // MARK: - レイアウト開始前に呼ばれる
    override func containerViewWillLayoutSubviews() {
        overlayView.frame = containerView!.bounds
        presentedView?.frame = frameOfPresentedViewInContainerView
        presentedView?.layer.cornerRadius = 10
        presentedView?.clipsToBounds = true
    }
    
    // MARK: - レイアウト開始後に呼ばれる
    override func containerViewDidLayoutSubviews() {
    }
    
    
}

extension BottomPresentationController {
    
    @objc func overlayViewDidTouch(_ sender: UITapGestureRecognizer) {
        presentedViewController.dismiss(animated: true, completion: nil)
    }
}

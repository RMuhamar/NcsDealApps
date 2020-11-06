//
//  ConsigneeController.swift
//  NcsDealApps
//
//  Created by Nusantara Card Semesta on 26/06/20.
//  Copyright © 2020 Nusantara Card Semesta. All rights reserved.
//

import UIKit
import Lottie

class ConsigneeController: UIViewController {

    @IBOutlet weak var AnimationView: AnimationView!
    
    enum CardState {
            case expanded
            case collapsed
        }
        
        var cardViewController:CardViewShipper!
        var visualEffectView:UIVisualEffectView!
        
        let cardHeight:CGFloat = UIScreen.main.bounds.height - 85
        let cardHandleAreaHeight:CGFloat = 300
        
        var cardVisible = false
        var nextState:CardState {
            return cardVisible ? .collapsed : .expanded
        }
        
        var runningAnimations = [UIViewPropertyAnimator]()
        var animationProgressWhenInterrupted:CGFloat = 0
        
        override func viewDidLoad() {
            super.viewDidLoad()
            setupCard()
    //        self.cardViewController.view.layer.cornerRadius = 30
            self.cardViewController.view.layer.shadowPath = UIBezierPath(rect: self.cardViewController.view.bounds).cgPath
            self.cardViewController.view.layer.shadowRadius = 5
            self.cardViewController.view.layer.shadowOffset = .zero
            self.cardViewController.view.layer.shadowOpacity = 0.5
            // Do any additional setup after loading the view.
            AnimationView.backgroundColor = .clear
            AnimationView.loopMode = .loop
            AnimationView.play()
        }
        
        func setupCard() {
            
            visualEffectView = UIVisualEffectView()
            visualEffectView.frame = self.view.frame
            self.view.addSubview(visualEffectView)
            
            cardViewController = CardViewShipper(nibName:"CardViewShipper", bundle:nil)
            self.addChild(cardViewController)
            self.view.addSubview(cardViewController.view)
            var heightnew = self.cardViewController.view.frame.height + 100
            
            cardViewController.view.frame = CGRect(x: 0, y: self.view.frame.height - cardHandleAreaHeight, width: self.view.bounds.width, height: heightnew)
            
            cardViewController.view.clipsToBounds = true
            
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ConsigneeController.handleCardTap(recognzier:)))
            let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(ConsigneeController.handleCardPan(recognizer:)))
            
            cardViewController.handleArea.addGestureRecognizer(tapGestureRecognizer)
            cardViewController.handleArea.addGestureRecognizer(panGestureRecognizer)

        }

        @objc
        func handleCardTap(recognzier:UITapGestureRecognizer) {
            switch recognzier.state {
            case .ended:
                animateTransitionIfNeeded(state: nextState, duration: 0.9)
            default:
                break
            }
        }
        
        @objc
        func handleCardPan (recognizer:UIPanGestureRecognizer) {
            switch recognizer.state {
            case .began:
                startInteractiveTransition(state: nextState, duration: 0.9)
            case .changed:
                let translation = recognizer.translation(in: self.cardViewController.handleArea)
                var fractionComplete = translation.y / cardHeight
                fractionComplete = cardVisible ? fractionComplete : -fractionComplete
                updateInteractiveTransition(fractionCompleted: fractionComplete)
            case .ended:
                continueInteractiveTransition()
            default:
                break
            }
            
        }
        
        func animateTransitionIfNeeded (state:CardState, duration:TimeInterval) {
            if runningAnimations.isEmpty {
                let frameAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {
                    switch state {
                    case .expanded:
                        self.cardViewController.view.frame.origin.y = UIScreen.main.bounds.height - self.view.frame.height
                    case .collapsed:
                        self.cardViewController.view.frame.origin.y = self.view.frame.height - self.cardHandleAreaHeight
                    }
                }
                
                frameAnimator.addCompletion { _ in
                    self.cardVisible = !self.cardVisible
                    self.runningAnimations.removeAll()
                }
                
                frameAnimator.startAnimation()
                runningAnimations.append(frameAnimator)
                
                
                let cornerRadiusAnimator = UIViewPropertyAnimator(duration: duration, curve: .linear) {
                    switch state {
                    case .expanded:
                        self.cardViewController.view.layer.cornerRadius = 40
                        self.cardViewController.view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
                        self.AnimationView.stop()
                    case .collapsed:
                        self.cardViewController.view.layer.cornerRadius = 0
                        self.AnimationView.play()
                    }
                }
                
                cornerRadiusAnimator.startAnimation()
                runningAnimations.append(cornerRadiusAnimator)
                
                let blurAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {
                    switch state {
                    case .expanded:
    //                    self.visualEffectView.effect = nil
                        self.visualEffectView.effect = UIBlurEffect(style: .dark)
                    case .collapsed:
                        self.visualEffectView.effect = nil
                    }
                }
                
                blurAnimator.startAnimation()
                runningAnimations.append(blurAnimator)
                
            }
        }
        
        func startInteractiveTransition(state:CardState, duration:TimeInterval) {
            if runningAnimations.isEmpty {
                animateTransitionIfNeeded(state: state, duration: duration)
            }
            for animator in runningAnimations {
                animator.pauseAnimation()
                animationProgressWhenInterrupted = animator.fractionComplete
            }
        }
        
        func updateInteractiveTransition(fractionCompleted:CGFloat) {
            for animator in runningAnimations {
                animator.fractionComplete = fractionCompleted + animationProgressWhenInterrupted
            }
        }
        
        func continueInteractiveTransition (){
            for animator in runningAnimations {
                animator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
            }
        }

}

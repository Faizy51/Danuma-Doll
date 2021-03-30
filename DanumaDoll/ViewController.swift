//
//  ViewController.swift
//  DanumaDoll
//
//  Created by Faizyy on 30/03/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    private var originalBounds = CGRect.zero
    private var originalCenter = CGPoint.zero
    
    private var animator: UIDynamicAnimator!
    private var attachmentBehavior: UIAttachmentBehavior!
    private var pushBehavior: UIPushBehavior!
    private var itemBehavior: UIDynamicItemBehavior!
    
    let ThrowingThreshold: CGFloat = 1000
    let ThrowingVelocityPadding: CGFloat = 35
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animator = UIDynamicAnimator(referenceView: view)
        originalBounds = imageView.bounds
        originalCenter = imageView.center
        
    }
    
    @IBAction func handleAttachmentGesture(sender: UIPanGestureRecognizer) {
        let location = sender.location(in: self.view)
        let boxLocation = sender.location(in: self.imageView)
        
        switch sender.state {
        case .began:
            animator.removeAllBehaviors()
            
            let centerOffset = UIOffset(horizontal: boxLocation.x - imageView.bounds.midX,
                                        vertical: boxLocation.y - imageView.bounds.midY)
            attachmentBehavior = UIAttachmentBehavior(item: imageView,
                                                      offsetFromCenter: centerOffset, attachedToAnchor: location)
            animator.addBehavior(attachmentBehavior)
            
            
        case .ended:
            animator.removeAllBehaviors()
            resetDemo()
//            let velocity = sender.velocity(in: view)
//            let magnitude = sqrt((velocity.x * velocity.x) + (velocity.y * velocity.y))
//
//            if magnitude > ThrowingThreshold {
//                let pushBehavior = UIPushBehavior(items: [imageView], mode: .instantaneous)
//                pushBehavior.pushDirection = CGVector(dx: velocity.x / 10, dy: velocity.y / 10)
//                pushBehavior.magnitude = magnitude / ThrowingVelocityPadding
//
//                self.pushBehavior = pushBehavior
//                animator.addBehavior(pushBehavior)
//
//                let angle = Int(arc4random_uniform(20)) - 10
//
//                itemBehavior = UIDynamicItemBehavior(items: [imageView])
//                itemBehavior.friction = 0.2
//                itemBehavior.allowsRotation = true
//                itemBehavior.addAngularVelocity(CGFloat(angle), for: imageView)
//                animator.addBehavior(itemBehavior)
//
//                let deadlineTime = DispatchTime.now() + .seconds(1)
//                DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
//                    self.resetDemo()
//                }
//            } else {
//                resetDemo()
//            }
        default:
            attachmentBehavior.anchorPoint = sender.location(in: view)
        }
    }
    
    func resetDemo() {
        animator.removeAllBehaviors()
        
        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.1, options: .allowAnimatedContent, animations: {
            self.imageView.bounds = self.originalBounds
            self.imageView.center = self.originalCenter
            self.imageView.transform = .identity
        }, completion: nil)
        
//        UIView.animate(withDuration: 0.45) {
//            self.imageView.bounds = self.originalBounds
//            self.imageView.center = self.originalCenter
//            self.imageView.transform = .identity
//        }
    }
    
}


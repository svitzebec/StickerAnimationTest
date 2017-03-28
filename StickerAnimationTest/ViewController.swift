//
//  ViewController.swift
//  StickerAnimationTest
//
//  Created by Svit Zebec on 27/03/2017.
//  Copyright © 2017 Svit Zebec. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var stickerView: StickerView!
    
    var shapeLayer: CAShapeLayer = CAShapeLayer()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        stickerView.placeholderImage = UIImage(named: "sticker-placeholder")
        stickerView.stickerImage = UIImage(named: "sticker-with-background")
        
        shapeLayer.path = UIBezierPath(ovalIn: CGRect(x: 100, y: 100, width: 200, height: 200)).cgPath
        shapeLayer.fillColor = UIColor.red.cgColor
        
        //view.layer.addSublayer(shapeLayer)
    }
    
    @IBAction func animatePressed(_ sender: UIButton) {
        stickerView.animate()
        
        /* CATransaction.begin()
        CATransaction.setAnimationDuration(1.0)
        
        let animation = CATransition()
        animation.duration = 1.2
        animation.startProgress = 1.0
        animation.endProgress = 0.0
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        animation.type = "pageCurl"
        animation.subtype = "fromRight"
        animation.isRemovedOnCompletion = false
        animation.fillMode = "extended"
        
        self.shapeLayer.add(animation, forKey: "pageCurlAnimation")
        
        CATransaction.commit() */
        
        /* UIView.animate(withDuration: 1, animations: {
            let animation = CATransition()
            animation.duration = 1.2
            animation.startProgress = 1.0
            animation.endProgress = 0.0
            animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            animation.type = "pageCurl"
            animation.subtype = "fromRight"
            animation.isRemovedOnCompletion = false
            animation.fillMode = "extended"
            
            self.shapeLayer.add(animation, forKey: "pageCurlAnimation")
        }) */
    }
}


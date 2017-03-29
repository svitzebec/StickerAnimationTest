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
    
    @IBOutlet weak var placeholderImageView: UIImageView!
    @IBOutlet weak var stickerImageView: UIImageView!
    @IBOutlet weak var containerView: UIView!
    
    var isCurled: Bool = false
    var curlView: XBCurlView?
    
    var originalStickerFrame: CGRect?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        stickerView.placeholderImage = UIImage(named: "sticker-placeholder")
        stickerView.stickerImage = UIImage(named: "sticker")
        
        curlView = XBCurlView(frame: containerView.bounds)
        curlView?.isOpaque = false
        curlView?.pageOpaque = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        curlView?.frame = containerView.bounds
    }
    
    @IBAction func animatePressed(_ sender: UIButton) {
//        stickerView.animate()
        
        if originalStickerFrame == nil {
            originalStickerFrame = stickerImageView.frame
        }
        
        if isCurled {
            curlView?.uncurlAnimated(withDuration: 1.2, completion: { _ in
                self.stickerImageView.frame = self.originalStickerFrame!
                self.containerView.addSubview(self.stickerImageView)
            })
            isCurled = false
        } else {
            curlView?.curl(stickerImageView, cylinderPosition: CGPoint(x: placeholderImageView.frame.origin.x, y: containerView.bounds.height / 2), cylinderAngle: .pi / 2.5, cylinderRadius: 50, animatedWithDuration: 1.2)
            isCurled = true
        }
    }
}


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
    
    var isCurled: Bool = false
    var curlView: XBCurlView?
    
    var originalStickerFrame: CGRect?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        stickerView.placeholderImage = UIImage(named: "sticker-placeholder")
        stickerView.stickerImage = UIImage(named: "sticker")
        
//        stickerImageView.image = imageWithImage(image: UIImage(named: "sticker")!, scaledToSize: CGSize(width: 85, height: 110))
//        placeholderImageView.image = imageWithImage(image: UIImage(named: "sticker-placeholder")!, scaledToSize: CGSize(width: 85, height: 110))
        
        stickerImageView.image = UIImage(named: "sticker")
        placeholderImageView.image = UIImage(named: "sticker-placeholder")
        
        stickerImageView.contentMode = .center
        placeholderImageView.contentMode = .center
        
        curlView = XBCurlView(frame: placeholderImageView.frame)
        curlView?.isOpaque = false
        curlView?.pageOpaque = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        curlView?.frame = placeholderImageView.frame
    }
    
    @IBAction func animatePressed(_ sender: UIButton) {
//        stickerView.animate()
        
        if originalStickerFrame == nil {
            originalStickerFrame = stickerImageView.frame
        }
        
        if isCurled {
            curlView?.uncurlAnimated(withDuration: 1.2, completion: { _ in
                self.stickerImageView.frame = self.originalStickerFrame!
                self.view.addSubview(self.stickerImageView)
            })
            isCurled = false
        } else {
            curlView?.curl(stickerImageView, cylinderPosition: CGPoint(x: (curlView!.bounds.width / 2) - 195, y: placeholderImageView.bounds.height / 2), cylinderAngle: .pi / 1.75, cylinderRadius: 80, animatedWithDuration: 1.2)
            isCurled = true
        }
    }
    
    private func imageWithImage(image:UIImage, scaledToSize newSize:CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0);
        image.draw(in: CGRect(origin: CGPoint.zero, size: CGSize(width: newSize.width, height: newSize.height)))
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
}


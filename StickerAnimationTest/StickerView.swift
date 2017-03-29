//
//  StickerView.swift
//  Pods
//
//  Created by Svit Zebec on 27/03/2017.
//
//

import UIKit

class StickerView: UIView {
    
    open var placeholderImage: UIImage? {
        didSet {
            placeholderImageView.image = placeholderImage
        }
    }
    open var stickerImage: UIImage? {
        didSet {
            stickerImageView.image = stickerImage
        }
    }
    
    var placeholderImageView: UIImageView
    var stickerImageView: UIImageView
    
    var curlView: XBCurlView?
    
    var isCurled: Bool = false
    
    //
    // MARK: StickerView init
    //
    
    public override init(frame: CGRect) {
        placeholderImageView = UIImageView(image: placeholderImage)
        stickerImageView = UIImageView(image: stickerImage)
        
        super.init(frame: frame)
        
        setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        placeholderImageView = UIImageView(image: placeholderImage)
        stickerImageView = UIImageView(image: stickerImage)
        
        super.init(coder: aDecoder)
        
        setup()
    }
    
    //
    // MARK: UIView
    //
    
    private func setup() {
        
        curlView = XBCurlView(frame: bounds)
        curlView?.isOpaque = false
        curlView?.pageOpaque = true
        
        addSubview(placeholderImageView)
        addSubview(stickerImageView)
        
        placeholderImageView.frame = bounds
        stickerImageView.frame = bounds
        
        translatesAutoresizingMaskIntoConstraints = false
        placeholderImageView.translatesAutoresizingMaskIntoConstraints = false
        stickerImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let placeholderTopConstraint = NSLayoutConstraint(item: placeholderImageView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0)
        let placeholderTrailingConstraint = NSLayoutConstraint(item: placeholderImageView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0)
        let placeholderBottomConstraint = NSLayoutConstraint(item: placeholderImageView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0)
        let placeholderLeadingConstraint = NSLayoutConstraint(item: placeholderImageView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0)
        
        //addConstraints([placeholderTopConstraint, placeholderTrailingConstraint, placeholderBottomConstraint, placeholderLeadingConstraint])
        
        let stickerTopConstraint = NSLayoutConstraint(item: stickerImageView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0)
        let stickerTrailingConstraint = NSLayoutConstraint(item: stickerImageView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0)
        let stickerBottomConstraint = NSLayoutConstraint(item: stickerImageView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0)
        let stickerLeadingConstraint = NSLayoutConstraint(item: stickerImageView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0)
        
        //addConstraints([stickerTopConstraint, stickerTrailingConstraint, stickerBottomConstraint, stickerLeadingConstraint])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        placeholderImageView.frame = bounds
        stickerImageView.frame = bounds
        
        curlView?.frame = bounds
    }
    
    func animate() {
        
        if isCurled {
            curlView?.uncurlAnimated(withDuration: 1.2, completion: { _ in
                self.stickerImageView.frame = self.placeholderImageView.frame
                self.addSubview(self.stickerImageView)
            })
            isCurled = false
        } else {
            curlView?.curl(stickerImageView, cylinderPosition: CGPoint(x: -100, y: bounds.height / 2), cylinderAngle: .pi / 2.5, cylinderRadius: 120, animatedWithDuration: 1.2)
            isCurled = true
        }
        
        //UIView.animate(withDuration: 1, animations: {
            
            /* let animation = CATransition()
            animation.duration = 1.2
            animation.startProgress = 1.0
            animation.endProgress = 0.0
            animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            animation.type = "pageCurl"
            animation.subtype = "fromRight"
            animation.isRemovedOnCompletion = false
            animation.fillMode = "extended"
            
            self.stickerImageView.layer.add(animation, forKey: "pageCurlAnimation")
            
            self.layer.shadowColor = UIColor.white.cgColor
            self.stickerImageView.layer.shadowColor = UIColor.white.cgColor
            self.placeholderImageView.layer.shadowColor = UIColor.white.cgColor */
        //})
        
    }
    
}

extension StickerView: CAAnimationDelegate {
    
    
    
}

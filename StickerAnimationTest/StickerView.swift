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
    
    var backgroundView: UIView = UIView()
    
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
        
        backgroundView.backgroundColor = UIColor.white
        
        addSubview(placeholderImageView)
        addSubview(stickerImageView)
        
        translatesAutoresizingMaskIntoConstraints = false
        placeholderImageView.translatesAutoresizingMaskIntoConstraints = false
        stickerImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let placeholderTopConstraint = NSLayoutConstraint(item: placeholderImageView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0)
        let placeholderTrailingConstraint = NSLayoutConstraint(item: placeholderImageView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0)
        let placeholderBottomConstraint = NSLayoutConstraint(item: placeholderImageView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0)
        let placeholderLeadingConstraint = NSLayoutConstraint(item: placeholderImageView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0)
        
        addConstraints([placeholderTopConstraint, placeholderTrailingConstraint, placeholderBottomConstraint, placeholderLeadingConstraint])
        
        let stickerTopConstraint = NSLayoutConstraint(item: stickerImageView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0)
        let stickerTrailingConstraint = NSLayoutConstraint(item: stickerImageView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0)
        let stickerBottomConstraint = NSLayoutConstraint(item: stickerImageView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0)
        let stickerLeadingConstraint = NSLayoutConstraint(item: stickerImageView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0)
        
        addConstraints([stickerTopConstraint, stickerTrailingConstraint, stickerBottomConstraint, stickerLeadingConstraint])
        
        bringSubview(toFront: placeholderImageView)
        bringSubview(toFront: stickerImageView)
        
        //placeholderImageView.backgroundColor = .clear
        //stickerImageView.backgroundColor = .clear
    }
    
    func animate() {
        
        backgroundView.frame = bounds
        
        //UIView.animate(withDuration: 1, animations: {
            
            let animation = CATransition()
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
            self.placeholderImageView.layer.shadowColor = UIColor.white.cgColor
        //})
        
    }
    
}

extension StickerView: CAAnimationDelegate {
    
    
    
}

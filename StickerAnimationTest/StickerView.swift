//
//  StickerView.swift
//  Pods
//
//  Created by Svit Zebec on 27/03/2017.
//
//

import UIKit

class StickerView: UIView {
    
    //
    // MARK: settable properties
    //
    
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
    open var contentEdgeInsets: UIEdgeInsets = .zero {
        didSet {
            updateFrames()
        }
    }
    open var stickerEdgeInsets: UIEdgeInsets = .zero {
        didSet {
            updateFrames()
        }
    }
    open var uncurledCylinderPosition: CGPoint?
    open var curledCylinderPosition: CGPoint = .zero
    open var cylinderAngle: CGFloat = .pi / 2
    open var cylinderRadius: CGFloat = 80
    open var curlAnimationDuration: Double = 1.2
    open var stickerOnAtStart: Bool = false
    
    //
    // MARK: private properties
    // 
    
    private var placeholderImageView: UIImageView
    private var stickerImageView: UIImageView
    private var stickerContainerView: UIView
    private var curlView: XBCurlView?
    
    private var isCurled: Bool = false
    private var isAnimating: Bool = false
    
    //
    // MARK: StickerView init
    //
    
    public override init(frame: CGRect) {
        placeholderImageView = UIImageView(image: placeholderImage)
        stickerImageView = UIImageView(image: stickerImage)
        stickerContainerView = UIView()
        
        super.init(frame: frame)
        
        setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        placeholderImageView = UIImageView(image: placeholderImage)
        stickerImageView = UIImageView(image: stickerImage)
        stickerContainerView = UIView()
        
        super.init(coder: aDecoder)
        
        setup()
    }
    
    //
    // MARK: UIView
    //
    
    private func setup() {
        
        updateFrames()
        
        stickerContainerView.addSubview(stickerImageView)
        addSubview(placeholderImageView)
        addSubview(stickerContainerView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if uncurledCylinderPosition == nil {
            uncurledCylinderPosition = CGPoint(x: bounds.width, y: bounds.height / 2)
        }
        
        if curlView == nil {
            curlView = XBCurlView(frame: bounds)
            curlView?.isOpaque = false
            curlView?.pageOpaque = true
            
            if !stickerOnAtStart {
                curlView?.draw(onFrontOfPage: stickerContainerView)
                addSubview(curlView!)
                stickerContainerView.isHidden = true
                
                curlView?.cylinderRadius = cylinderRadius
                curlView?.cylinderAngle = cylinderAngle
                curlView?.cylinderPosition = curledCylinderPosition
                curlView?.redraw()
                
                isCurled = true
            }
        }
        
        updateFrames()
    }
    
    func animate() {
        guard !isAnimating else {
            return
        }
        
        isCurled ? uncurl() : curl()
    }
    
    // 
    // MARK: convenience
    //
    
    private func uncurl() {
        
        guard let curlView = curlView, let uncurledCylinderPosition = uncurledCylinderPosition else {
            return
        }
        
        isAnimating = true
        isCurled = false
        
        curlView.setCylinderPosition(uncurledCylinderPosition, cylinderAngle: cylinderAngle, cylinderRadius: cylinderRadius, animatedWithDuration: curlAnimationDuration, completion: { 
            self.stickerContainerView.isHidden = false
            curlView.removeFromSuperview()
            curlView.stopAnimating()
            
            self.addSubview(self.stickerContainerView)
            self.updateFrames()
            self.isAnimating = false
        })
        
        curlView.startAnimating()
    }
    
    private func curl() {
        
        guard let curlView = curlView else {
            return
        }
        
        isAnimating = true
        isCurled = true
        
        if let uncurledCylinderPosition = uncurledCylinderPosition {
            curlView.cylinderPosition = uncurledCylinderPosition
        }
        
        curlView.draw(onFrontOfPage: stickerContainerView)
        curlView.setCylinderPosition(curledCylinderPosition, cylinderAngle: cylinderAngle, cylinderRadius: cylinderRadius, animatedWithDuration: curlAnimationDuration, completion: { 
            curlView.stopAnimating()
            self.isAnimating = false
        })
        
        addSubview(curlView)
        stickerContainerView.isHidden = true
        
        curlView.startAnimating()
    }
    
    private func updateFrames() {
        
        stickerContainerView.frame = bounds
        placeholderImageView.frame = CGRect(x: contentEdgeInsets.left, y: contentEdgeInsets.top, width: bounds.width - contentEdgeInsets.left - contentEdgeInsets.right, height: bounds.height - contentEdgeInsets.top - contentEdgeInsets.bottom)
        stickerImageView.frame = CGRect(x: contentEdgeInsets.left - stickerContainerView.frame.origin.x + stickerEdgeInsets.left, y: contentEdgeInsets.top - stickerContainerView.frame.origin.y + stickerEdgeInsets.top, width: stickerContainerView.frame.width - contentEdgeInsets.left - contentEdgeInsets.right - stickerEdgeInsets.left - stickerEdgeInsets.right, height: stickerContainerView.frame.height - contentEdgeInsets.top - contentEdgeInsets.bottom - stickerEdgeInsets.top - stickerEdgeInsets.bottom)
        
        curlView?.frame = stickerContainerView.frame
    }
    
}

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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        stickerView.placeholderImage = UIImage(named: "sticker-placeholder")
        stickerView.stickerImage = UIImage(named: "sticker")
        
        stickerView.contentEdgeInsets = UIEdgeInsets(top: 40, left: 40, bottom: 40, right: 40)
        stickerView.stickerEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    @IBAction func animatePressed(_ sender: UIButton) {
        stickerView.animate()
    }
}


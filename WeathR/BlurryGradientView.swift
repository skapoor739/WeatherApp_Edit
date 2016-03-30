//
//  BlurryGradientView.swift
//  WeathR
//
//  Created by Shivam Kapur on 01/03/16.
//  Copyright © 2016 Shivam Kapur. All rights reserved.
//

import UIKit
import QuartzCore

class BlurryGradientView: UIView {

    @IBOutlet var gradientView: UIView!
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        NSBundle.mainBundle().loadNibNamed("BlurryGradientView", owner: self, options: nil)
        
        
        let color1 = UIColor(red: 255/255, green: 197/255, blue: 0/255, alpha: 1.0).CGColor
        let color2 = UIColor(red: 194/255, green: 21/255, blue: 0/255, alpha: 1.0).CGColor
        
        let blurEffect = UIBlurEffect(style: .Light)
        let visualEffects = UIVisualEffectView(effect: blurEffect)
        visualEffects.frame = gradientView.bounds
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [color1,color2]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.frame = gradientView.bounds
        self.layer.insertSublayer(gradientLayer, atIndex: 0)
        

    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
}

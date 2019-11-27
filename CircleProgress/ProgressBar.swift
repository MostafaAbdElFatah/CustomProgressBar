//
//  ViewController.swift
//  CircleProgress
//
//  Created by Mostafa on 11/27/19.
//  Copyright © 2019 Mostafa. All rights reserved.
//

import UIKit

class ProgressBar: UIView {

    var value = 0.25
    var timer:Timer!
    let shaperLayer = CAShapeLayer()
    var plusSatingLayer:CAShapeLayer!
    var label:UILabel = {
        let label = UILabel()
        label.text = "Loading ..."
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.frame = CGRect(x: 0, y: 0, width: 150, height:100)
        return label
    }()
    
    override func draw(_ rect: CGRect) {
        //let center = self.view.center
        let circulePath = UIBezierPath(arcCenter: .zero, radius: 75, startAngle: -CGFloat.pi / 2 , endAngle: 2 * CGFloat.pi, clockwise: true)
        
        
        
        
        self.plusSatingLayer = CAShapeLayer()
        plusSatingLayer.path = circulePath.cgPath
        plusSatingLayer.strokeColor = UIColor.clear.cgColor
        plusSatingLayer.lineCap = .round
        //plusSatingLayer.lineWidth = 0
        plusSatingLayer.position = CGPoint(x: self.frame.height / 2 , y: self.frame.width / 2)
        //75, 18, 53
        plusSatingLayer.fillColor = #colorLiteral(red: 0.5098039216, green: 0, blue: 0.4869058099, alpha: 1)
        self.layer.addSublayer(plusSatingLayer)
        animatePlusSatingLayer()
        
        // track
        let trackLayer = CAShapeLayer()
        trackLayer.path = circulePath.cgPath
        trackLayer.strokeColor = UIColor.lightGray.cgColor
        trackLayer.lineCap = .round
        trackLayer.lineWidth = 10
        trackLayer.position = CGPoint(x: self.frame.height / 2 , y: self.frame.width / 2)
        trackLayer.fillColor = UIColor.clear.cgColor
        self.layer.addSublayer(trackLayer)
        
        
        shaperLayer.path = circulePath.cgPath
        // 212, 0, 100
        shaperLayer.strokeColor = UIColor.init(red: 212, green: 0, blue: 100, alpha: 1).cgColor
        shaperLayer.lineCap = .round
        shaperLayer.lineWidth = 10
        shaperLayer.strokeEnd = 0
        shaperLayer.position = CGPoint(x: self.frame.height / 2 , y: self.frame.width / 2)
        shaperLayer.fillColor =  UIColor.black.cgColor
        self.layer.addSublayer(shaperLayer)
        
        
        timer = Timer.scheduledTimer(withTimeInterval: 4, repeats: true) { (timer) in
            let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
            basicAnimation.fromValue = 0
            basicAnimation.toValue = 0.80
            basicAnimation.duration = 3
            basicAnimation.fillMode = .forwards
            basicAnimation.isRemovedOnCompletion = false
            self.shaperLayer.add(basicAnimation, forKey: "ubasic")
            
            let basicAnimation2 = CABasicAnimation(keyPath: "strokeStart")
            basicAnimation.fromValue = 0
            basicAnimation2.toValue = 0.80
            basicAnimation2.duration = 4
            basicAnimation2.fillMode = .forwards
            basicAnimation2.isRemovedOnCompletion = false
            self.shaperLayer.add(basicAnimation2, forKey: "asdsfd")
            //            self.value += 0.25
            //            if self.value > 1 {
            //                self.value = 0.25
            //                basicAnimation.fromValue = 0
            //                basicAnimation.isRemovedOnCompletion = true
            //                //basicAnimation2.fromValue = 0
            //                //basicAnimation2.isRemovedOnCompletion = true
            //            }
        }
        timer.fire()
        self.label.center = CGPoint(x: self.frame.height / 2 , y: self.frame.width / 2)
        self.addSubview(label)
        self.bringSubviewToFront(label)
        //self.container.backgroundColor = .black
        //self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }
    
    private func animatePlusSatingLayer(){
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.toValue = 1.2
        animation.duration = 1
        animation.autoreverses = true
        animation.repeatCount = Float.infinity
        plusSatingLayer.add(animation, forKey: "plusSatingLayer")
    }
    
    @objc func handleTap()  {
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.fromValue = value - 0.25
        basicAnimation.toValue = value
        value += 0.25
        basicAnimation.duration = 5
        basicAnimation.fillMode = .forwards
        basicAnimation.isRemovedOnCompletion = false
        shaperLayer.add(basicAnimation, forKey: "ubasic")
    }


}


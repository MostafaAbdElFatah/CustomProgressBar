//
//  ViewController.swift
//  CircleProgress
//
//  Created by Mostafa on 11/27/19.
//  Copyright © 2019 Mostafa. All rights reserved.
//

import UIKit

class ProgressBar: UIView {
    
    // MARK: - circle paramters
    //private var circleRadius:CGFloat = 75
    private var circleStartAngle:CGFloat = -CGFloat.pi / 2
    private var circleEndAngle:CGFloat = 2 * CGFloat.pi
    
//    @IBInspectable
//    var radius: CGFloat {
//        get {
//            return self.circleRadius
//        }
//        set {
//            self.circleRadius = newValue
//        }
//    }
    
    @IBInspectable
    var startAngle: CGFloat {
        get {
            return self.circleStartAngle
        }
        set {
            self.circleStartAngle = newValue
            self.redraw()
        }
    }
    
    @IBInspectable
    var endAngle: CGFloat {
        get {
            return self.circleEndAngle
        }
        set {
            self.circleEndAngle = newValue
            self.redraw()
        }
    }
    
    // MARK: - plussating circle paramters
    private var plussatingLayerScale:CGFloat = 1.2
    private var plussatingLayerColor:UIColor = #colorLiteral(red: 0.5098039216, green: 0, blue: 0.4869058099, alpha: 1)
    private var plussatingLayerStrokeColor:UIColor = UIColor.clear
    private let plussatingLayer = CAShapeLayer()
    
    @IBInspectable
       var plussatingScale: CGFloat {
           get {
               return self.plussatingLayerScale
           }
           set {
               self.plussatingLayerScale = newValue
               self.redraw()
           }
       }
    
    @IBInspectable
    var plussatingColor: UIColor {
        get {
            return self.plussatingLayerColor
        }
        set {
            self.plussatingLayerColor = newValue
            self.redraw()
        }
    }
    
    @IBInspectable
    var plussatingStrokeColor: UIColor {
        get {
            return self.plussatingLayerStrokeColor
        }
        set {
            self.plussatingLayerStrokeColor = newValue
            self.redraw()
        }
    }
    
    // MARK: - track circle paramters
    private var trackLayerStrokeColor:UIColor = UIColor.lightGray
    private var trackLayerLineWidth:CGFloat = 10
    private var trackLayerColor:UIColor = UIColor.clear
    private let trackLayer = CAShapeLayer()
    
    @IBInspectable
    var trackStrokeColor: UIColor {
        get {
            return self.trackLayerStrokeColor
        }
        set {
            self.trackLayerStrokeColor = newValue
            self.redraw()
        }
    }
    
    @IBInspectable
    var trackLineWidth: CGFloat {
        get {
            return self.trackLayerLineWidth
        }
        set {
            self.trackLayerLineWidth = newValue
            self.redraw()
        }
    }
    
    @IBInspectable
    var trackColor: UIColor {
        get {
            return self.trackLayerColor
        }
        set {
            self.trackLayerColor = newValue
            self.redraw()
        }
    }
    
    // MARK: - shaperLayer
    private var shaperLayerStrokeColor:UIColor = UIColor.red
    private var shaperLayerLineCap:CAShapeLayerLineCap = .round
    private var shaperLayerLineWidth:CGFloat = 10
    private var shaperLayerColor:UIColor =  UIColor.black
    private var shaperLayerStrokeStart:CGFloat = 0
    private var shaperLayerStrokeEnd:CGFloat = 0.005
    private let shaperLayer = CAShapeLayer()
    
    
    @IBInspectable
    var shaperStrokeColor: UIColor {
        get {
            return self.shaperLayerStrokeColor
        }
        set {
            self.shaperLayerStrokeColor = newValue
            self.redraw()
        }
    }
    
    var shaperLineCap: CAShapeLayerLineCap {
        get {
            return self.shaperLayerLineCap
        }
        set {
            self.shaperLayerLineCap = newValue
            self.redraw()
        }
    }
    
    @IBInspectable
    var shaperLineWidth: CGFloat {
        get {
            return self.shaperLayerLineWidth
        }
        set {
            self.shaperLayerLineWidth = newValue
            self.redraw()
        }
    }
    
    @IBInspectable
    var shaperColor: UIColor {
        get {
            return self.shaperLayerColor
        }
        set {
            self.shaperLayerColor = newValue
            self.redraw()
        }
    }
    
    
    @IBInspectable
    var shaperStrokeStart: CGFloat {
        get {
            return self.shaperLayerStrokeStart
        }
        set {
            self.shaperLayerStrokeStart = newValue
            self.redraw()
        }
    }
    
    @IBInspectable
    var shaperStrokeEnd: CGFloat {
        get {
            return self.shaperLayerStrokeEnd
        }
        set {
            self.shaperLayerStrokeEnd = newValue
            self.redraw()
        }
    }
    
    // MARK: - label
    private var textLabel = "Loading ..."
    private var textLabelColor:UIColor = .white
    private var textLabelFont = UIFont.boldSystemFont(ofSize: 20)
    
    @IBInspectable
    var text: String {
        get {
            return self.textLabel
        }
        set {
            self.textLabel = newValue
            self.redraw()
        }
    }
    
    @IBInspectable
    var textColor: UIColor {
        get {
            return self.textLabelColor
        }
        set {
            self.textLabelColor = newValue
            self.redraw()
        }
    }
    
       var textFont: UIFont {
           get {
               return self.textLabelFont
           }
           set {
               self.textLabelFont = newValue
               self.redraw()
           }
       }
    
    private lazy var label:UILabel = {
        let label = UILabel()
        label.text = "Loading ..."
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.frame = self.frame
        return label
    }()
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        self.redraw()
        self.addSubview(label)
    }
    
    func redraw()  {
        var raduis:CGFloat = 75
        if bounds.height <= bounds.width {
            raduis = bounds.height / 2 - 30
        }else{
           raduis = bounds.width / 2 - 50
        }
        
        let circlePath = UIBezierPath(arcCenter: .zero
            , radius: raduis
            , startAngle:circleStartAngle
            , endAngle: circleEndAngle
            , clockwise: true)
        
        /// plussatingLayer
        plussatingLayer.path = circlePath.cgPath
        plussatingLayer.strokeColor = plussatingLayerStrokeColor.cgColor
        plussatingLayer.lineCap = .round
        plussatingLayer.fillColor = plussatingColor.cgColor
        plussatingLayer.removeFromSuperlayer()
        layer.addSublayer(plussatingLayer)
        
        /// trackLayer
        trackLayer.path = circlePath.cgPath
        trackLayer.strokeColor = trackLayerStrokeColor.cgColor
        trackLayer.lineCap = .round
        trackLayer.lineWidth = trackLayerLineWidth
        trackLayer.fillColor = trackLayerColor.cgColor
        trackLayer.removeFromSuperlayer()
        layer.addSublayer(trackLayer)
        
        /// shaperLayer
        shaperLayer.path = circlePath.cgPath
        shaperLayer.strokeColor = shaperLayerStrokeColor.cgColor
        shaperLayer.lineCap = shaperLayerLineCap
        shaperLayer.lineWidth = shaperLayerLineWidth
        shaperLayer.fillColor =  shaperLayerColor.cgColor
        shaperLayer.strokeStart = shaperLayerStrokeStart
        shaperLayer.strokeEnd = shaperLayerStrokeEnd
        shaperLayer.removeFromSuperlayer()
        layer.addSublayer(shaperLayer)
        
        /// LoadingLabel
        label.text = textLabel
        label.textColor = textLabelColor
        label.font = textLabelFont
        bringSubviewToFront(label)
    }
    
    func animate() {
        /// plussating  animation
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.toValue = plussatingScale
        animation.duration = 1
        animation.autoreverses = true
        animation.repeatCount = Float.infinity
        plussatingLayer.add(animation, forKey: "plusSatingLayer")
        
        /// loading animation
        let basicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        basicAnimation.fromValue = 0
        basicAnimation.toValue = CGFloat.pi * 2
        basicAnimation.repeatCount = .infinity
        basicAnimation.duration = 5
        shaperLayer.add(basicAnimation, forKey: "rotate")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.center = CGPoint(x: bounds.midX, y: bounds.midY)
        trackLayer.position = CGPoint(x: bounds.midX, y: bounds.midY)
        plussatingLayer.position = CGPoint(x: bounds.midX, y: bounds.midY)
        shaperLayer.position = CGPoint(x: bounds.midX, y: bounds.midY)
    }
    
}


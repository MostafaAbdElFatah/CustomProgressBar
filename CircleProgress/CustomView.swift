//
//  CustomView.swift
//  CircleProgress
//
//  Created by Mostafa on 11/27/19.
//  Copyright © 2019 Mostafa. All rights reserved.
//

import UIKit

class CustomView: UIView {

    private var paths: [Int: UIBezierPath] = [:]
    private var circleConstraints: [NSLayoutConstraint] = []

    
    @IBInspectable var radiusFactor: CGFloat = 1 {
        didSet {
            setNeedsLayout()
        }
    }
    
    @IBInspectable var shift: CGFloat = -142 {
        didSet {
            setNeedsLayout()
        }
    }
    
    private lazy var tapGestureRecognizer: UITapGestureRecognizer = { [unowned self] in
        let tgr = UITapGestureRecognizer.init(target: self, action: #selector(tapped(_:)))
        return tgr
        }()
    
    @objc private func tapped(_ recognizer: UITapGestureRecognizer) {
        for (i, path) in paths {
            if path.contains(recognizer.location(in: self)) {
                print("sector \(i) is tapped")
            }
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addGestureRecognizer(tapGestureRecognizer)
    }
    
    override func draw(_ rect: CGRect) {
        // Drawing code
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        //context.clear(rect)
        
        let innerRadius:CGFloat = 100
        let outerRadius:CGFloat = 175
        let innerCenter = self.center
        
        let step = (360.0 / CGFloat(10))
        let sectorAngle = 360 / CGFloat(10)
        
        let shiftStep = -180 + sectorAngle / 2
        for i in 0...9 {
            let angle = (step * CGFloat(i) + shiftStep)
            
            let point1 = CGPoint.init(x: innerRadius * cos(angle.degreesToRadians), y: (innerRadius) *
                sin(angle.degreesToRadians))
            let point2 = CGPoint.init(x: outerRadius * cos(angle.degreesToRadians), y: (outerRadius) *
                sin(angle.degreesToRadians))
            
            let point4 = CGPoint.init(x: (innerRadius) * cos((angle + step).degreesToRadians), y: (innerRadius) *
                sin((angle + step).degreesToRadians))
            
            
            let path = UIBezierPath.init()
            path.move(to: point1.applying(.init(translationX: innerCenter.x, y: innerCenter.y)))
            path.addLine(to: point2.applying(.init(translationX: innerCenter.x, y: innerCenter.y)))
            path.addArc(withCenter: innerCenter, radius: outerRadius, startAngle: angle.degreesToRadians, endAngle: (angle + step).degreesToRadians, clockwise: true)
            path.addLine(to: point4.applying(.init(translationX: innerCenter.x, y: innerCenter.y)))
            path.addArc(withCenter: innerCenter, radius: innerRadius, startAngle: (angle + step).degreesToRadians, endAngle: angle.degreesToRadians, clockwise: false)
            path.close()
            
            paths[i] = path
            
            context.addPath(path.cgPath)
            context.setFillColor(UIColor.lightGray.cgColor)
            context.fillPath()
            
            context.addPath(path.cgPath)
            context.setStrokeColor(UIColor.black.cgColor)
            context.setLineWidth(3)
            context.strokePath()
            
            let label = UILabel()
            label.textAlignment = .center
            label.textColor = .white
            label.font = UIFont.boldSystemFont(ofSize: 30)
            label.text = "\(i)"
            self.addSubview(label)
           
        }
        
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = .init(width: 0, height: 5)
        self.layer.shadowPath = UIBezierPath.init(ovalIn: self.bounds).cgPath
        
        /////
    }
    
    override func layoutSubviews() {
        guard subviews.isEmpty == false else {
            super.layoutSubviews()
            return
        }
        
        for c in circleConstraints {
            removeConstraint(c)
        }
        
        let radius = 140 * radiusFactor
        let step: CGFloat = CGFloat(360 / subviews.count)
        for i in stride(from: 0, to: subviews.count, by: 1) {
            let angle = CGFloat(i) * step + shift
            let x = radius * cos(angle.degreesToRadians)
            let y = radius * sin(angle.degreesToRadians)
            
            subviews[i].translatesAutoresizingMaskIntoConstraints = false
            let cX = NSLayoutConstraint.init(item: subviews[i], attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: x)
            addConstraint(cX)
            
            let cY = NSLayoutConstraint.init(item: subviews[i], attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: y)
            addConstraint(cY)
            
            circleConstraints.append(contentsOf: [cX, cY])
        }
    }
    
    
}


//MARK: - extension CGFloat degreesToRadians
extension CGFloat {
    var degreesToRadians: CGFloat {
        get {
            return (self * .pi) / 180
        }
    }
}

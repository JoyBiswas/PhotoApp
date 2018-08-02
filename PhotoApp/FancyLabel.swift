//
//  FancyLabel.swift
//  PhotoApp
//
//  Created by RIO on 6/5/18.
//  Copyright © 2018 MacBook Air. All rights reserved.
//

import UIKit

class FancyLabel: UILabel {
    
//    override func awakeFromNib() {
//
//        self.draw(self.bounds)
//        self.configureLabel()
//    }
//
//    override func draw(_ rect: CGRect) {
//        let path =  UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.topLeft , .topRight], cornerRadii: CGSize(width: 5.0, height: 5.0))
//        let maskLayer = CAShapeLayer()
//        maskLayer.path = path.cgPath
//        self.layer.mask = maskLayer
//
//    }
////    override func drawText(in rect: CGRect) {
////        let insets = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
////        super.drawText(in: UIEdgeInsetsInsetRect(rect, insets))
////    }
//
//    public override func prepareForInterfaceBuilder() {
//        super.prepareForInterfaceBuilder()
//        configureLabel()
//    }
//
//    func configureLabel() {
//        font = UIFont(name:"Avenir-Black", size:9)
//    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.commonInit()
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    func commonInit(){
                let path =  UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.topLeft , .topRight], cornerRadii: CGSize(width: 5.0, height: 5.0))
                let maskLayer = CAShapeLayer()
                maskLayer.path = path.cgPath
                self.layer.mask = maskLayer
    }
    func setProperties(borderWidth: Float, borderColor: UIColor) {
        self.layer.borderWidth = CGFloat(borderWidth)
        self.layer.borderColor = borderColor.cgColor
    }
}

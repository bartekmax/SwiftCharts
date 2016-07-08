//
//  ChartLayerGenerator.swift
//  SwiftCharts
//
//  Created by marcin.wlodarczyk@icloud.com on 31/03/16.
//  Copyright (c) 2015 ivanschuetz. All rights reserved.
//

import Foundation

protocol ChartLayerGenerator {
    func generate() -> CALayer
}

struct ChartLineLayerGenerator: ChartLayerGenerator {
    let point1: CGPoint
    let point2: CGPoint
    let lineWidth: CGFloat
    let strokeColor: UIColor
    let fillColor: UIColor
    let lineJoin: String
    
    init(point1 point1: CGPoint, point2: CGPoint, lineWidth: CGFloat, strokeColor: UIColor,
                fillColor: UIColor? = nil, lineJoin: String = kCALineJoinBevel) {
        self.point1 = point1
        self.point2 = point2
        self.lineWidth = lineWidth
        self.strokeColor = strokeColor
        self.fillColor = fillColor ?? strokeColor
        self.lineJoin = lineJoin
    }
    
    func generate() -> CALayer {
        let path = UIBezierPath()
        path.moveToPoint(point1)
        path.addLineToPoint(point2)
        let lineLayer = CAShapeLayer()
        lineLayer.lineJoin = lineJoin
        lineLayer.fillColor   = fillColor.CGColor
        lineLayer.lineWidth   = lineWidth
        lineLayer.path = path.CGPath
        lineLayer.strokeColor = strokeColor.CGColor
        return lineLayer

    }
}

struct ChartTextLayerGenerator: ChartLayerGenerator {
    let frame: CGRect
    let text: String
    let font: UIFont
    let alignmentMode: String
    let foregroundColor: UIColor
    
    init(layerFrame frame: CGRect, text: String, font: UIFont, alignmentMode: String = kCAAlignmentCenter, foregroundColor: UIColor) {
        self.frame = frame
        self.text = text
        self.font = font
        self.alignmentMode = alignmentMode
        self.foregroundColor = foregroundColor
    }
    
    func generate() -> CALayer {
        let textLayer = CATextLayer()
        textLayer.frame = frame
        textLayer.string = NSAttributedString(string: text, attributes: [NSFontAttributeName: font])
        textLayer.foregroundColor = foregroundColor.CGColor
        textLayer.font = font.fontName
        textLayer.fontSize = font.pointSize
        textLayer.alignmentMode = alignmentMode
        textLayer.contentsScale = UIScreen.mainScreen().scale
        return textLayer
    }
}

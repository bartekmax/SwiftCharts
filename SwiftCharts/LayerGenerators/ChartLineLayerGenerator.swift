//
//  ChartLineLayerGenerator.swift
//  SwiftCharts
//
//  Created by marcinwlodarczyk on 22/09/16.
//  Copyright © 2016 ivanschuetz. All rights reserved.
//

import Foundation

struct ChartLineLayerGenerator: ChartLayerGenerator {
    let point1: CGPoint
    let point2: CGPoint
    let lineWidth: CGFloat
    let strokeColor: UIColor
    let fillColor: UIColor
    let lineJoin: String
    
    init(point1: CGPoint, point2: CGPoint, lineWidth: CGFloat, strokeColor: UIColor, fillColor: UIColor? = nil, lineJoin: String = kCALineJoinBevel) {
        self.point1 = point1
        self.point2 = point2
        self.lineWidth = lineWidth
        self.strokeColor = strokeColor
        self.fillColor = fillColor ?? strokeColor
        self.lineJoin = lineJoin
    }
    
    func generate() -> CALayer {
        let path = UIBezierPath()
        path.move(to: point1)
        path.addLine(to: point2)
        let lineLayer = CAShapeLayer()
        lineLayer.lineJoin = lineJoin
        lineLayer.fillColor   = fillColor.cgColor
        lineLayer.lineWidth   = lineWidth
        lineLayer.path = path.cgPath
        lineLayer.strokeColor = strokeColor.cgColor
        return lineLayer
    }
}

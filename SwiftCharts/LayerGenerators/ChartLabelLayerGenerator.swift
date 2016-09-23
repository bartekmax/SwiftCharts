//
//  ChartLabelLayerGenerator.swift
//  SwiftCharts
//
//  Created by wlodarcm on 22/09/16.
//  Copyright © 2016 ivanschuetz. All rights reserved.
//

import Foundation

struct ChartLabelLayerGenerator: ChartLayerGenerator {
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
        textLayer.string = text
        textLayer.foregroundColor = foregroundColor.cgColor
        textLayer.font = font.fontName as CFTypeRef?
        textLayer.fontSize = font.pointSize
        textLayer.alignmentMode = alignmentMode
        textLayer.contentsScale = UIScreen.main.scale
        return textLayer
    }
}

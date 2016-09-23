//
//  ChartAxisYHighLayerDefault.swift
//  SwiftCharts
//
//  Created by ischuetz on 25/04/15.
//  Copyright (c) 2015 ivanschuetz. All rights reserved.
//

import UIKit

/// A ChartAxisLayer for high Y axes
class ChartAxisYHighLayerDefault: ChartAxisYLayerDefault {
    
    override var low: Bool {return false}

    /// The start point of the axis line.
    override var lineP1: CGPoint {
        return self.p1
    }

    /// The end point of the axis line.
    override var lineP2: CGPoint {
        return self.p2
    }
    
    override func initDrawers() {
        let labelsOffset = self.settings.labelsToAxisSpacingY + self.settings.axisStrokeWidth
        let axisTitleLabelsOffset = labelsOffset + self.labelsMaxWidth + self.settings.axisTitleLabelsToLabelsSpacing
        self.axisTitleLabelDrawers = self.generateAxisTitleLabelsDrawers(offset: axisTitleLabelsOffset)
    }
    
    override func initLayers() {
        self.lineLayer = self.generateLineLayer(offset: 0)
        let labelsOffset = self.settings.labelsToAxisSpacingY + self.settings.axisStrokeWidth
        self.labelLayers = self.generateLabelLayers(offset: labelsOffset)
    }
    
    override func generateLineLayer(offset: CGFloat) -> CALayer {
        let halfStrokeWidth = self.settings.axisStrokeWidth / 2 // we want that the stroke begins at the beginning of the frame, not in the middle of it
        let x = self.p1.x + offset + halfStrokeWidth
        let p1 = CGPoint(x: x, y: self.p1.y)
        let p2 = CGPoint(x: x, y: self.p2.y)
        let lineWidth = self.settings.axisStrokeWidth
        let strokeColor = self.settings.lineColor
        return ChartLineLayerGenerator(point1: p1, point2: p2, lineWidth: lineWidth, strokeColor: strokeColor).generate()
    }
    
    override func labelsX(offset: CGFloat, labelWidth: CGFloat, textAlignment: ChartLabelTextAlignment) -> CGFloat {
        var labelsX: CGFloat
        switch textAlignment {
        case .left, .default:
            labelsX = self.p1.x + offset
        case .right:
            labelsX = self.p1.x + offset + self.labelsMaxWidth - labelWidth
        case .center:
            labelsX = self.p1.x + offset + self.labelsMaxWidth - labelWidth / 2
        }
        return labelsX
    }
}

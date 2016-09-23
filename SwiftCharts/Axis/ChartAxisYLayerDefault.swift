//
//  ChartAxisYLayerDefault.swift
//  SwiftCharts
//
//  Created by ischuetz on 25/04/15.
//  Copyright (c) 2015 ivanschuetz. All rights reserved.
//

import UIKit

/// A ChartAxisLayer for Y axes
class ChartAxisYLayerDefault: ChartAxisLayerDefault {
    
    override var height: CGFloat {
        return self.p2.y - self.p1.y
    }
    
    var labelsMaxWidth: CGFloat {
        if let labelsWidthY = settings.labelsWidthY {
            return labelsWidthY
        } else if self.labelLayers.isEmpty {
            return self.maxLabelWidth(self.axisValues)
        } else {
            return self.labelLayers.reduce(0) {maxWidth, labelLayer in
                max(maxWidth, labelLayer.bounds.size.width)
            }
        }
    }
    
    override var width: CGFloat {
        return self.labelsMaxWidth + self.settings.axisStrokeWidth + self.settings.labelsToAxisSpacingY + self.settings.axisTitleLabelsToLabelsSpacing + self.axisTitleLabelsWidth
    }
    
    override var length: CGFloat {
        return p1.y - p2.y
    }

    override func generateAxisTitleLabelsDrawers(offset: CGFloat) -> [ChartLabelDrawer] {
        
        if let firstTitleLabel = self.axisTitleLabels.first {
            
            if self.axisTitleLabels.count > 1 {
                print("WARNING: No support for multiple definition labels on vertical axis. Using only first one.")
            }
            let axisLabel = firstTitleLabel
            let labelSize = ChartUtils.textSize(axisLabel.text, font: axisLabel.settings.font)
            let settings = axisLabel.settings
            let newSettings = ChartLabelSettings(font: settings.font, fontColor: settings.fontColor, rotation: settings.rotation, rotationKeep: settings.rotationKeep)
            let axisLabelDrawer = ChartLabelDrawer(text: axisLabel.text, screenLoc: CGPoint(
                x: self.p1.x + offset,
                y: self.p2.y + ((self.p1.y - self.p2.y) / 2) - (labelSize.height / 2)), settings: newSettings)
            
            return [axisLabelDrawer]
            
        } else { // definitionLabels is empty
            return []
        }
    }

    
    override func screenLocForScalar(_ scalar: Double, firstAxisScalar: Double) -> CGFloat {
        return self.p1.y - self.innerScreenLocForScalar(scalar, firstAxisScalar: firstAxisScalar)
    }
    
    
    func generateLabelLayers(offset: CGFloat) -> [CALayer] {

        var layers: [CALayer] = []
        var lastLayer: CALayer?
        
        axisValues.forEach { axisValue in
            guard let axisLabel = axisValue.labels.first, !axisValue.hidden else {
                return
            }
            let scalar = axisValue.scalar
            let y = self.screenLocForScalar(scalar)
            let labelSize = ChartUtils.textSize(axisLabel.text, font: axisLabel.settings.font)
            let labelY = y - (labelSize.height / 2)
            let labelX = self.labelsX(offset: offset, labelWidth: labelSize.width, textAlignment: axisLabel.settings.textAlignment)
            let frame = CGRect(x: labelX, y: labelY, width: labelSize.width, height: labelSize.height)
            let labelLayer = ChartLabelLayerGenerator(layerFrame: frame, text: axisLabel.text, font: axisLabel.settings.font, alignmentMode: axisLabel.settings.textAlignment.alignmentMode, foregroundColor: axisLabel.settings.fontColor).generate()
            layers.append(labelLayer)
            
            if let lastLayer = lastLayer {
                let intersection = frame.intersection(lastLayer.frame)
                if intersection != CGRect.null {
                    labelLayer.frame.origin = CGPoint(x: labelLayer.frame.origin.x, y: labelLayer.frame.origin.y - intersection.height / 2)
                    lastLayer.frame.origin = CGPoint(x: lastLayer.frame.origin.x, y: lastLayer.frame.origin.y + intersection.height / 2)
                }
            }
            lastLayer = labelLayer
        }
        return layers
    }
    
    func labelsX(offset: CGFloat, labelWidth: CGFloat, textAlignment: ChartLabelTextAlignment) -> CGFloat {
        fatalError("override")
    }
    
    fileprivate func maxLabelWidth(_ axisLabels: [ChartAxisLabel]) -> CGFloat {
        return axisLabels.reduce(CGFloat(0)) {maxWidth, label in
            return max(maxWidth, ChartUtils.textSize(label.text, font: label.settings.font).width)
        }
    }
    
    fileprivate func maxLabelWidth(_ axisValues: [ChartAxisValue]) -> CGFloat {
        return axisValues.reduce(CGFloat(0)) {maxWidth, axisValue in
            return max(maxWidth, self.maxLabelWidth(axisValue.labels))
        }
    }
}

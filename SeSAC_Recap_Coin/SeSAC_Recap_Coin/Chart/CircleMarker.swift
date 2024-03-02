//
//  CircleMarker.swift
//  SeSAC_Recap_Coin
//
//  Created by 박희지 on 3/2/24.
//

import UIKit
import DGCharts

class CircleMarker: MarkerImage {
    
    private var color: UIColor
    private var radius: CGFloat = 4
    private var borderRadius: CGFloat = 5.5
    
    init(color: UIColor) {
        self.color = color
        super.init()
    }
    
    override func draw(context: CGContext, point: CGPoint) {
        let borderRect = CGRect(x: point.x - borderRadius, y: point.y - borderRadius, width: borderRadius * 2, height: borderRadius * 2)
        context.setFillColor(UIColor.white.cgColor)
        context.fillEllipse(in: borderRect)
        
        let circleRect = CGRect(x: point.x - radius, y: point.y - radius, width: radius * 2, height: radius * 2)
        context.setFillColor(color.cgColor)
        context.fillEllipse(in: circleRect)
        
        context.restoreGState()
    }
}


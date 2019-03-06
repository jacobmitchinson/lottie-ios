//
//  ShapeContainerLayer.swift
//  lottie-swift
//
//  Created by Brandon Withrow on 1/30/19.
//

import Foundation
import QuartzCore

/**
 The base layer that holds Shapes and Shape Renderers
 */
class ShapeContainerLayer: CALayer {
  
  private(set) var renderLayers: [ShapeContainerLayer] = []
  
  override init() {
    super.init()
    self.actions = [
      "position" : NSNull(),
      "bounds" : NSNull(),
      "anchorPoint" : NSNull(),
      "transform" : NSNull(),
      "opacity" : NSNull()
    ]
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  var renderScale: CGFloat = 1 {
    didSet {
      renderLayers.forEach( { $0.renderScale = renderScale } )
    }
  }
  
  func insertRenderLayer(_ layer: ShapeContainerLayer) {
    renderLayers.append(layer)
    insertSublayer(layer, at: 0)
  }
  
  func markRenderUpdates(forFrame: CGFloat) {
    if self.hasRenderUpdate(forFrame: forFrame) {
      self.rebuildContents(forFrame: forFrame)
    }
    renderLayers.forEach { $0.markRenderUpdates(forFrame: forFrame) }
  }
  
  func hasRenderUpdate(forFrame: CGFloat) -> Bool {
    return false
  }
  
  func rebuildContents(forFrame: CGFloat) {
    /// Override
  }
  
}

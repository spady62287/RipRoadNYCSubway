//
//  AnimatedLoader.swift
//  RipRoadNYCSubway
//
//  Created by Daniel Spady on 2021-04-01.
//

import UIKit

class AnimatedLoader: UIView {
    
    @IBInspectable var tick: CGFloat = 1.0 {
        didSet { setNeedsDisplay() }
    }
    
    fileprivate var timer: Timer?
    
    fileprivate static let numberOfFrames = 34.0
    
    func start() {
        guard timer == nil else { return }
        
        timer = Timer(timeInterval: 0.7 / AnimatedLoader.numberOfFrames,
                      target: self,
                      selector: #selector(AnimatedLoader.timerEvent),
                      userInfo: nil,
                      repeats: true)
        
        RunLoop.main.add(timer!, forMode: .common)
    }
    
    func stop() {
        timer?.invalidate()
        timer = nil
    }

    @objc func timerEvent() {
        tick += 1
    }
}

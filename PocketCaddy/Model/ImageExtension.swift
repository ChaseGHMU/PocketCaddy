//
//  ImageExtension.swift
//  PocketCaddy
//
//  Created by Chase Allen on 4/23/18.
//  Copyright © 2018 Chase Allen. All rights reserved.
//

import UIKit

extension UIImage {
    public func rotateImageByDegrees(_ degrees: CGFloat) -> UIImage {
        
        let degreesToRadians: (CGFloat) -> CGFloat = {
            return $0 / 180.0 * CGFloat(Double.pi)
        }
        
        let rotatedViewBox = UIView(frame: CGRect(origin: CGPoint.zero, size: self.size))
        let t = CGAffineTransform(rotationAngle: degreesToRadians(degrees))
        rotatedViewBox.transform = t
        let rotatedsize = rotatedViewBox.frame.size
        
        UIGraphicsBeginImageContext(rotatedsize)
        let bitmap = UIGraphicsGetCurrentContext()
        
        bitmap?.translateBy(x: rotatedsize.width / 2.0, y: rotatedsize.height / 2.0)
        bitmap?.rotate(by: degreesToRadians(degrees))
        
        bitmap?.scaleBy(x: 1.0, y: -1.0)
        bitmap?.draw(self.cgImage!, in: CGRect(x: -self.size.width / 2, y: -self.size.height / 2, width: self.size.width, height: self.size.height))
        let cgImage = bitmap!.makeImage()!
        return UIImage(cgImage: cgImage)
    }
}

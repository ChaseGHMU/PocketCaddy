//
//  ImageViewExtension.swift
//  PocketCaddy
//
//  Created by Chase Allen on 4/23/18.
//  Copyright © 2018 Chase Allen. All rights reserved.
//

import UIKit

extension UIImageView {
    func tintImageColor(color: UIColor) {
        self.image = self.image!.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        self.tintColor = color
    }
}

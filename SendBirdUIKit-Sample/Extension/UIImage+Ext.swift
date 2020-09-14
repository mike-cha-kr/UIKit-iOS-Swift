//
//  UIImage+Ext.swift
//  SendBirdUIKit-Sample
//
//  Created by Tez Park on 2020/09/14.
//  Copyright © 2020 SendBird, Inc. All rights reserved.
//

import UIKit

extension UIImage {
    func resize(with targetSize: CGSize) -> UIImage {
        let size = self.size
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        let scale = min(widthRatio, heightRatio)
        
        let scaledImageSize = CGSize(
            width: size.width * scale,
            height: size.height * scale
        )
        let renderer = UIGraphicsImageRenderer(size: scaledImageSize)
        
        let scaledImage = renderer.image { _ in
            self.draw(in: CGRect(origin: .zero, size: scaledImageSize))
        }
        
        return scaledImage
    }
}

//
//  BottomSheetView.swift
//  MapBottomSheet
//
//  Created by Dariel on 2018/8/25.
//  Copyright © 2018年 Dariel. All rights reserved.
//

import UIKit

private let cornerRadius: CGFloat = 12

class BottomSheetBackgroundView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        addCornerRadiusAndShadow(cornerRadius: cornerRadius, shadowOffset: CGSize(width: 2, height: -2), shadowRadius: 2, color: UIColor.darkGray, opacity: 0.4)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    

}


extension UIView {
    
    /// 添加圆角和阴影
    public func addCornerRadiusAndShadow(cornerRadius: CGFloat, shadowOffset: CGSize, shadowRadius: CGFloat, color: UIColor, opacity: Float) {
        
        self.layer.cornerRadius = cornerRadius
        self.layer.shadowColor = color.cgColor
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowOffset = shadowOffset
        self.layer.shadowOpacity = opacity
    }
    
}

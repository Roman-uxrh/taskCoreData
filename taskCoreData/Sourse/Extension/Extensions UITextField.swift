//
//  Extensions UITextField.swift
//  taskCoreData
//
//  Created by admin on 13.04.2023.
//

import UIKit

extension UITextField {
    
    func setLeftIcon(_ image: UIImage?) {
        let iconView = UIImageView(frame: CGRect(x: 20, y: 0, width: 30, height: 30))
        iconView.image = image
        iconView.tintColor = .black
        let iconContainerView: UIView = UIView(frame: CGRect(x: 20, y: 0, width: 60, height: 30))
        iconContainerView.addSubview(iconView)
        leftView = iconContainerView
        leftViewMode = .always
    }
}


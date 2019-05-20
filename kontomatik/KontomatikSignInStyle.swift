//
//  KontomatikSignInStyle.swift
//  Kontomatik
//
//  Created by Lukas Gergel on 28/02/2019.
//  Copyright © 2019 Zonky a.s. All rights reserved.
//
import UIKit


public struct KontomatikSignInStyle {
    /// Controls the background color of an error message alert box
    let alertErrorBgColor: UIColor?
    /// Controls the border color of an error message alert box
    let alertErrorBorderColor: UIColor?
    /// Controls the text color of an error message alert box
    let alertErrorTextColor: UIColor?
    
    /// The background color of the widget
    let bodyBgColor: UIColor?
    /// Controls the corner roundness of all input components (buttons, inputs, alert box). The default value is 4px
    let borderRadius: Int?
    
    /// Controls the background color of the “Change bank” button
    let btnBgColor: UIColor?
    /// Controls the border color of the “Change bank” button
    let btnBorderColor: UIColor?
    /// Controls the text color of the “Change bank” button
    let btnTextColor: UIColor?
    
    /// Controls the background color of the “Next” and “Try again” buttons
    let btnPrimaryBgColor: UIColor?
    /// Controls the border color of the “Next” and “Try again” buttons
    let btnPrimaryBorderColor: UIColor?
    /// Controls the text color of the “Next” and “Try again” buttons
    let btnPrimaryTextColor: UIColor?
    
    /// Controls the background color of all inputs and dropdown lists.
    let inputBgColor: UIColor?
    /// Controls the border color of all inputs and dropdown lists.
    let inputBorderColor: UIColor?
    /// Controls the text color of all inputs and dropdown lists.
    let inputTextColor: UIColor?
    /// Controls the text color of disabled inputs and dropdown lists.
    let inputDisabledTextColor: UIColor?
    /// Controls the border color of an input that has focus
    let inputBorderFocusColor: UIColor?
    
    /// Controls the background color of a menu item the mouse pointer is over
    let menuHighlightBgColor: UIColor?
    /// Controls the all texts color
    let textColor: UIColor?
    
    public func toDict() -> [String: Any] {
        var params: [String: Any] = [:]
        
        alertErrorBgColor.map { params["alertErrorBgColor"] = $0.hexValue()  }
        alertErrorBorderColor.map { params["alertErrorBorderColor"] = $0.hexValue()  }
        alertErrorTextColor.map { params["alertErrorTextColor"] = $0.hexValue()  }
        bodyBgColor.map { params["bodyBgColor"] = $0.hexValue()  }
        borderRadius.map { params["borderRadius"] = $0  }
        btnBgColor.map { params["btnBgColor"] = $0.hexValue()  }
        btnBorderColor.map { params["btnBorderColor"] = $0.hexValue()  }
        btnTextColor.map { params["btnTextColor"] = $0.hexValue()  }
        btnPrimaryBgColor.map { params["btnPrimaryBgColor"] = $0.hexValue()  }
        btnPrimaryBorderColor.map { params["btnPrimaryBorderColor"] = $0.hexValue()  }
        btnPrimaryTextColor.map { params["btnPrimaryTextColor"] = $0.hexValue()  }
        inputBgColor.map { params["inputBgColor"] = $0.hexValue()  }
        inputBorderColor.map { params["inputBorderColor"] = $0.hexValue()  }
        inputTextColor.map { params["inputTextColor"] = $0.hexValue()  }
        inputDisabledTextColor.map { params["inputDisabledTextColor"] = $0.hexValue()  }
        inputBorderFocusColor.map { params["inputBorderFocusColor"] = $0.hexValue()  }
        menuHighlightBgColor.map { params["menuHighlightBgColor"] = $0.hexValue()  }
        textColor.map { params["textColor"] = $0.hexValue()  }
        return params
    }
}

extension KontomatikSignInStyle {
    
    public init(alertErrorBgColor: UIColor?, alertErrorBorderColor: UIColor?, alertErrorTextColor: UIColor?, bodyBgColor: UIColor?, borderRadius: Int?, btnBgColor: UIColor?, btnBorderColor: UIColor?, btnTextColor: UIColor?, btnPrimaryBgColor: UIColor?, btnPrimaryBorderColor: UIColor?, btnPrimaryTextColor: UIColor?, inputBgColor: UIColor?, inputBorderColor: UIColor?, inputTextColor: UIColor?, inputDisabledTextColor: UIColor?, inputBorderFocusColor: UIColor?, menuHighlightBgColor: UIColor?) {
        self.alertErrorBgColor = alertErrorBgColor
        self.alertErrorBorderColor = alertErrorBorderColor
        self.alertErrorTextColor = alertErrorTextColor
        self.bodyBgColor = bodyBgColor
        self.borderRadius = borderRadius
        self.btnBgColor = btnBgColor
        self.btnBorderColor = btnBorderColor
        self.btnTextColor = btnTextColor
        self.btnPrimaryBgColor = btnPrimaryBgColor
        self.btnPrimaryBorderColor = btnPrimaryBorderColor
        self.btnPrimaryTextColor = btnPrimaryTextColor
        self.inputBgColor = inputBgColor
        self.inputBorderColor = inputBorderColor
        self.inputTextColor = inputTextColor
        self.inputDisabledTextColor = inputDisabledTextColor
        self.inputBorderFocusColor = inputBorderFocusColor
        self.menuHighlightBgColor = menuHighlightBgColor
        self.textColor = nil
        
    }
}

fileprivate extension UIColor {
    func hexValue() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        
        getRed(&r, green: &g, blue: &b, alpha: &a)
        
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        
        return NSString(format:"#%06x", rgb) as String
    }
}

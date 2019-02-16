//
//  LayoutView.swift
//  Instagrid
//
//  Created by Cindy Perat on 30/01/2019.
//  Copyright © 2019 Cindy Perat. All rights reserved.
//

import UIKit

class LayoutView: UIView {
    @IBOutlet private var image1Container: UIView!
    @IBOutlet private var image2Container: UIView!
    @IBOutlet private var image3Container: UIView!
    @IBOutlet private var image4Container: UIView!
    
    @IBOutlet private var layoutSelection: UIView!
    
    // For portrait device
    @IBOutlet private var layoutSelectionLeadingPosition: NSLayoutConstraint!
    
    // For landscape device
    @IBOutlet private var layoutSelectionTopPosition: NSLayoutConstraint!
    
    @IBOutlet private var layoutsList: UIStackView!
    @IBOutlet private var layout1Selection: UIView!
    @IBOutlet private var layout2Selection: UIView!
    @IBOutlet private var layout3Selection: UIView!
    
    var layout: Layout = .layout2 {
        didSet {
            setLayout(layout)
        }
    }
    
    private func setLayout(_ layout: Layout) {
        switch layout {
        case .layout1:
            image1Container.isHidden = false
            image2Container.isHidden = true
            image3Container.isHidden = false
            image4Container.isHidden = false
            
            if UIDevice.current.orientation.isLandscape {
                layoutSelectionTopPosition.constant = layout1Selection.frame.origin.y
            } else {
                layoutSelectionLeadingPosition.constant = layout1Selection.frame.origin.x
            }
        case .layout2:
            image1Container.isHidden = false
            image2Container.isHidden = false
            image3Container.isHidden = false
            image4Container.isHidden = true
            
            if UIDevice.current.orientation.isLandscape {
                layoutSelectionTopPosition.constant = layout2Selection.frame.origin.y
            } else {
                layoutSelectionLeadingPosition.constant = layout2Selection.frame.origin.x
            }
        case .layout3:
            image1Container.isHidden = false
            image2Container.isHidden = false
            image3Container.isHidden = false
            image4Container.isHidden = false
            
            if UIDevice.current.orientation.isLandscape {
                layoutSelectionTopPosition.constant = layout3Selection.frame.origin.y
            } else {
                layoutSelectionLeadingPosition.constant = layout3Selection.frame.origin.x
            }
        }
    }
}

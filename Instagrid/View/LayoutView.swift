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
        
    enum Layout {
        case layout1, layout2, layout3
    }
    
    var layout: Layout = .layout1 {
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
            
            layoutSelection.frame.origin.x = 0
        case .layout2:
            image1Container.isHidden = false
            image2Container.isHidden = false
            image3Container.isHidden = false
            image4Container.isHidden = true
            
            layoutSelection.frame.origin.x = 100
        case .layout3:
            image1Container.isHidden = false
            image2Container.isHidden = false
            image3Container.isHidden = false
            image4Container.isHidden = false
            
            layoutSelection.frame.origin.x = 200
        }
    }
}

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
    @IBOutlet private var image1ContainerWidth: NSLayoutConstraint!
    @IBOutlet private var image1ContainerHeight: NSLayoutConstraint!
    @IBOutlet private var image1ContainerLeadingSpace: NSLayoutConstraint!
    @IBOutlet private var image1ContainerTopSpace: NSLayoutConstraint!
    
    @IBOutlet private var image2Container: UIView!
    @IBOutlet private var image2ContainerWidth: NSLayoutConstraint!
    @IBOutlet private var image2ContainerHeight: NSLayoutConstraint!
    @IBOutlet private var image2ContainerLeadingSpace: NSLayoutConstraint!
    @IBOutlet private var image2ContainerTopSpace: NSLayoutConstraint!
    
    @IBOutlet private var image3Container: UIView!
    @IBOutlet private var image3ContainerWidth: NSLayoutConstraint!
    @IBOutlet private var image3ContainerHeight: NSLayoutConstraint!
    @IBOutlet private var image3ContainerLeadingSpace: NSLayoutConstraint!
    @IBOutlet private var image3ContainerTopSpace: NSLayoutConstraint!
    
    @IBOutlet private var image4Container: UIView!
    @IBOutlet private var image4ContainerWidth: NSLayoutConstraint!
    @IBOutlet private var image4ContainerHeight: NSLayoutConstraint!
    @IBOutlet private var image4ContainerLeadingSpace: NSLayoutConstraint!
    @IBOutlet private var image4ContainerTopSpace: NSLayoutConstraint!
    
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
            image1ContainerWidth.constant = 270
            image1ContainerHeight.constant = 127.5
            image1ContainerLeadingSpace.constant = 15
            image1ContainerTopSpace.constant = 15
            
            image2ContainerWidth.constant = 127.5
            image2ContainerHeight.constant = 127.5
            image2ContainerLeadingSpace.constant = 15
            image2ContainerTopSpace.constant = 157.5
            
            image3ContainerWidth.constant = 127.5
            image3ContainerHeight.constant = 127.5
            image3ContainerLeadingSpace.constant = 157.7
            image3ContainerTopSpace.constant = 157.5
            
            image4Container.isHidden = true
            
            layoutSelection.frame.origin.x = 0
        case .layout2:
            image1ContainerWidth.constant = 127.5
            image1ContainerHeight.constant = 127.5
            image1ContainerLeadingSpace.constant = 15
            image1ContainerTopSpace.constant = 15
            
            image2ContainerWidth.constant = 127.5
            image2ContainerHeight.constant = 127.5
            image2ContainerLeadingSpace.constant = 157.5
            image2ContainerTopSpace.constant = 15
            
            image3ContainerWidth.constant = 270
            image3ContainerHeight.constant = 127.5
            image3ContainerLeadingSpace.constant = 15
            image3ContainerTopSpace.constant = 157.5
            
            image4Container.isHidden = true
            
            layoutSelection.frame.origin.x = 100
        case .layout3:
            image1ContainerWidth.constant = 127.5
            image1ContainerHeight.constant = 127.5
            image1ContainerLeadingSpace.constant = 15
            image1ContainerTopSpace.constant = 15
            
            image2ContainerWidth.constant = 127.5
            image2ContainerHeight.constant = 127.5
            image2ContainerLeadingSpace.constant = 157.5
            image2ContainerTopSpace.constant = 15
            
            image3ContainerWidth.constant = 127.5
            image3ContainerHeight.constant = 127.5
            image3ContainerLeadingSpace.constant = 15
            image3ContainerTopSpace.constant = 157.5
            
            image4Container.isHidden = false
            image4ContainerWidth.constant = 127.5
            image4ContainerHeight.constant = 127.5
            image4ContainerLeadingSpace.constant = 157.5
            image4ContainerTopSpace.constant = 157.5
            
            layoutSelection.frame.origin.x = 200
        }
    }
}

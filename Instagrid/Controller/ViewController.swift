//
//  ViewController.swift
//  Instagrid
//
//  Created by Cindy Perat on 08/11/2018.
//  Copyright © 2018 Cindy Perat. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var mainLayout: LayoutView!
    @IBOutlet weak var image1View: UIImageView!
    @IBOutlet weak var image2View: UIImageView!
    @IBOutlet weak var image3View: UIImageView!
    @IBOutlet weak var image4View: UIImageView!
    private var selectedImageView: UIImageView!
    
    @IBOutlet weak var layout1Button: UIButton!
    @IBOutlet weak var layout2Button: UIButton!
    @IBOutlet weak var layout3Button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainLayout.layout = .layout2
    }
    
    @IBAction func didTapImage1Button() {
        selectedImageView = image1View
        pickImage()
    }
    
    @IBAction func didTapImage2Button() {
        selectedImageView = image2View
        pickImage()
    }
    
    @IBAction func didTapImage3Button() {
        selectedImageView = image3View
        pickImage()
    }
    
    @IBAction func didTapImage4Button() {
        selectedImageView = image4View
        pickImage()
    }
    
    private func pickImage() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        selectedImageView.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didTapLayout1Button() {
        mainLayout.layout = .layout1
    }
    
    @IBAction func didTapLayout2Button() {
        mainLayout.layout = .layout2
    }
    
    @IBAction func didTapLayout3Button() {
        mainLayout.layout = .layout3
    }
}

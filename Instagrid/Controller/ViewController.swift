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
    
    @IBOutlet weak var shareIndicationLabel: UILabel!
    
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
        changeLabelAccordingToOrientation(label: shareIndicationLabel)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        changeLabelAccordingToOrientation(label: shareIndicationLabel)
    }
    
    private func changeLabelAccordingToOrientation(label: UILabel) {
        if UIDevice.current.orientation.isLandscape {
            shareIndicationLabel.text = "Swipe left to share"
        } else {
            shareIndicationLabel.text = "Swipe up to share"
        }
    }
    
    @IBAction func touchImage1Button() {
        selectedImageView = image1View
        pickImage()
    }
    
    @IBAction func touchImage2Button() {
        selectedImageView = image2View
        pickImage()
    }
    
    @IBAction func touchImage3Button() {
        selectedImageView = image3View
        pickImage()
    }
    
    @IBAction func touchImage4Button() {
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
    
    @IBAction func touchLayout1Button() {
        mainLayout.layout = .layout1
    }
    
    @IBAction func touchLayout2Button() {
        mainLayout.layout = .layout2
    }
    
    @IBAction func touchLayout3Button() {
        mainLayout.layout = .layout3
    }
    
    @IBAction func swipeMainLayout(_ sender: UIPanGestureRecognizer) {
        // Exécuter le switch que si toutes les photos du layout ont été importées
        
        let direction = sender.velocity(in: mainLayout)
        
        if UIDevice.current.orientation.isLandscape {
            if direction.x < 0 {
                switch sender.state {
                case .began, .changed:
                    moveViewHorizontally(gesture: sender, view: mainLayout)
                case .ended, .cancelled:
                    swipeLeftFromViewPosition(view: mainLayout)
                default:
                    break
                }
            }
        } else {
            if direction.y < 0 {
                switch sender.state {
                case .began, .changed:
                    moveViewVertically(gesture: sender, view: mainLayout)
                case .ended, .cancelled:
                    swipeUpFromViewPosition(view: mainLayout)
                default:
                    break
                }
            }
        }
    }
    
    private func moveViewHorizontally(gesture: UIPanGestureRecognizer, view: UIView) {
        let translation = gesture.translation(in: view)
        view.transform = CGAffineTransform(translationX: translation.x, y: 0)
    }
    
    private func swipeLeftFromViewPosition(view: UIView) {
        let screenWidth = UIScreen.main.bounds.width
        let translationTransform = CGAffineTransform(translationX: -screenWidth, y: 0)
        
        UIView.animate(withDuration: 0.3, animations: {
            view.transform = translationTransform
        }) { (success) in
            if success {
                self.swipeUpFromScreenBottomToViewOrigin(view: view)
                
                let imageToShare = self.viewToImage(view: self.mainLayout)
                self.shareImage(image: imageToShare)
            }
        }
    }
    
    private func moveViewVertically(gesture: UIPanGestureRecognizer, view: UIView) {
        let translation = gesture.translation(in: view)
        view.transform = CGAffineTransform(translationX: 0, y: translation.y)
    }
    
    private func swipeUpFromViewPosition(view: UIView) {
        let screenHeight = UIScreen.main.bounds.height
        let translationTransform = CGAffineTransform(translationX: 0, y: -screenHeight)
        
        UIView.animate(withDuration: 0.3, animations: {
            view.transform = translationTransform
        }) { (success) in
            if success {
                self.swipeUpFromScreenBottomToViewOrigin(view: view)
                
                let imageToShare = self.viewToImage(view: self.mainLayout)
                self.shareImage(image: imageToShare)
            }
        }
    }
    
    private func swipeUpFromScreenBottomToViewOrigin(view: UIView) {
        // Place view at the bottom, out of the screen
        let screenHeight = UIScreen.main.bounds.height
        view.transform = CGAffineTransform(translationX: 0, y: screenHeight)
        
        // Replace view to its original place
        UIView.animate(withDuration: 0.3, animations: {
            view.transform = .identity
        })
    }
    
    private func shareImage(image: UIImage) {
        let shareViewController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        present(shareViewController, animated: true, completion: nil)
    }
    
    private func viewToImage(view: UIView) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: view.bounds.size)
        let image = renderer.image { context in
            view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        }
        return image
    }
}

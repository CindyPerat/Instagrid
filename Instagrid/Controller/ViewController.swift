//
//  ViewController.swift
//  Instagrid
//
//  Created by Cindy Perat on 08/11/2018.
//  Copyright © 2018 Cindy Perat. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // MARK: Outlets
    
    @IBOutlet weak var shareIndicationLabel: UILabel!
    
    @IBOutlet weak var mainLayout: LayoutView!
    @IBOutlet weak var image1View: UIImageView!
    @IBOutlet weak var image2View: UIImageView!
    @IBOutlet weak var image3View: UIImageView!
    @IBOutlet weak var image4View: UIImageView!
    
    @IBOutlet weak var layout1Button: UIButton!
    @IBOutlet weak var layout2Button: UIButton!
    @IBOutlet weak var layout3Button: UIButton!
    
    // MARK: - Properties
    
    enum shareIndicationText: String {
        case up = "Swipe up to share"
        case left = "Swipe left to share"
    }
    
    private var selectedImageView: UIImageView!
    
    // MARK: - Actions
    
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
        if (mainLayout.layout == .layout1 && image1View.image != nil && image3View.image != nil && image4View.image != nil) ||
            (mainLayout.layout == .layout2 && image1View.image != nil && image2View.image != nil && image3View.image != nil) ||
            (mainLayout.layout == .layout3 && image1View.image != nil && image2View.image != nil && image3View.image != nil && image4View.image != nil) {
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
    }
    
    // MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainLayout.layout = .layout2
        changeShareIndicationLabelAtLaunch(label: shareIndicationLabel)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        changeShareIndicationLabelWhenTransition(label: shareIndicationLabel)
    }
    
    // Modify the "share indication label" for the launch of the application
    private func changeShareIndicationLabelAtLaunch(label: UILabel) {
        if UIApplication.shared.statusBarOrientation == .landscapeLeft ||
            UIApplication.shared.statusBarOrientation == .landscapeRight {
            shareIndicationLabel.text = shareIndicationText.left.rawValue
        } else if UIApplication.shared.statusBarOrientation == .portrait ||
            UIApplication.shared.statusBarOrientation == .portraitUpsideDown {
            shareIndicationLabel.text = shareIndicationText.up.rawValue
        }
    }
    
    // Modify the "share indication label" when the device orientation changes
    private func changeShareIndicationLabelWhenTransition(label: UILabel) {
        if UIDevice.current.orientation.isLandscape {
            shareIndicationLabel.text = shareIndicationText.left.rawValue
        } else {
            shareIndicationLabel.text = shareIndicationText.up.rawValue
        }
    }
    
    // Prepare and display the image picker
    private func pickImage() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.modalPresentationStyle = .overCurrentContext
        present(imagePicker, animated: true, completion: nil)
    }
    
    // Place the picked image in image view and hide the image picker
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            selectedImageView.image = pickedImage
        }
        dismiss(animated: true, completion: nil)
    }
    
    // Move view to the left by following the finger's gesture
    private func moveViewHorizontally(gesture: UIPanGestureRecognizer, view: UIView) {
        let translation = gesture.translation(in: view)
        view.transform = CGAffineTransform(translationX: translation.x, y: 0)
    }
    
    // Move view to the top by following the finger's gesture
    private func moveViewVertically(gesture: UIPanGestureRecognizer, view: UIView) {
        let translation = gesture.translation(in: view)
        view.transform = CGAffineTransform(translationX: 0, y: translation.y)
    }
    
    // Swipe the view from the bottom of the screen to its original position
    private func swipeUpFromScreenBottomToViewOrigin(view: UIView) {
        // Place the view at the bottom, out of the screen
        let screenHeight = UIScreen.main.bounds.height
        view.transform = CGAffineTransform(translationX: 0, y: screenHeight)
        
        // Replace the view to its original position
        UIView.animate(withDuration: 0.3, animations: {
            view.transform = .identity
        })
    }
    
    // Realize the complete swipe left animation, from the view's original position to the left of the screen and then
    // from the bottom of the screen to the view's original place
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
    
    // Realize the complete swipe up animation, from the view's original position to the top of the screen and then
    // from the bottom of the screen to the view's original place
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
    
    // Prepare and display the share panel
    private func shareImage(image: UIImage) {
        let shareViewController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        present(shareViewController, animated: true, completion: nil)
    }
    
    // Generate an image from a view
    private func viewToImage(view: UIView) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: view.bounds.size)
        let image = renderer.image { context in
            view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        }
        return image
    }
}

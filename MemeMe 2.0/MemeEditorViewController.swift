//
//  MemeEditorViewController.swift
//  MemeMe 2.0
//
//  Created by Marky Jordan on 5/4/20.
//  Copyright © 2020 Marky Jordan. All rights reserved.
//

import Foundation
import UIKit

class MemeEditorViewController: UIViewController {

    // MARK: - Outlets/Properties
        
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var toolBar: UIToolbar!
    
    var meme: Meme!
    var memedImage = UIImage()
    
    let memeTextAttributes: [NSAttributedString.Key: Any] = [
        
        .font: UIFont(name: "Impact", size: 40)!,
        .strokeColor: UIColor(white: 0.0, alpha: 1.0), // UIColor = black
        .foregroundColor: UIColor(white: 1.0, alpha: 1.0), // UIColor = white
        .strokeWidth: NSNumber(-5.0)
    ]
    
    // MARK: - Text Field Delegate Objects
    
    let memeTextFieldDelegate = MemeTextFieldsDelegate()
    
    // MARK: Life Cycle

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        initializeTextField(textField: topTextField, text: "TAP TO EDIT TOP TEXT")
        initializeTextField(textField: bottomTextField, text: "TAP TO EDIT BOTTOM TEXT")
        
        // disable share button
        shareButton.isEnabled = false
    }

    override func viewWillAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        
        // check if camera is available
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        
        // subscribe to keyboard notifications
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        
        // unsubsribe from keyboard notifications
        unsubscribeFromKeyboardNotifications()
    }
    
    func initializeTextField(textField: UITextField, text: String) {
        textField.delegate = memeTextFieldDelegate
        textField.text = text
        textField.defaultTextAttributes = memeTextAttributes
        textField.textAlignment = .center
    }
    
    // MARK: - NSNotification Functions
    
    // observers
    func subscribeToKeyboardNotifications() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // implement functions to act on notifications
    @objc func keyboardWillShow(_ notification: Notification) {
        
        if bottomTextField.isEditing, view.frame.origin.y == 0 {
            view.frame.origin.y -= getKeyboardHeight(notification)
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        
        view.frame.origin.y = 0
    }
    
    func getKeyboardHeight(_ notification: Notification) -> CGFloat {
        
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
    // MARK: - UIImagePickerControllerDelegate Methods
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let originalImage = info[.originalImage] as? UIImage {
            
            // set photoImageView to display the selected image
            photoImageView.image = originalImage
        }
        dismiss(animated: true, completion: nil )
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func hideNavAndToolBars(isHidden: Bool) {
        
        navigationBar.isHidden = isHidden
        toolBar.isHidden = isHidden
    }
    
    // MARK: - Image Picker
    
    @IBAction func selectImageFromAlbum(_ sender: Any) {
        
        let imagePickerVC = UIImagePickerController()
        
        // set the delegate(s)
        imagePickerVC.delegate = self
        
        // specify sourceType
        imagePickerVC.sourceType = .photoLibrary
        
        // enable share button
        shareButton.isEnabled = true
        
        present(imagePickerVC, animated: true, completion: nil)
    }
    
    @IBAction func selectImageFromCamera(_ sender: Any) {
        
        let imagePickerVC = UIImagePickerController()
        
        // set the delegate(s)
        imagePickerVC.delegate = self
        
        // specify sourceType
        imagePickerVC.sourceType = .camera
        
        // enable share button
        shareButton.isEnabled = true
        
        present(imagePickerVC, animated: true, completion: nil)
    }
    
    func generateMemedImage() -> UIImage {

        // hide toolbar and navigation bar
        hideNavAndToolBars(isHidden: true)
        
        // render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        // show toolbar and navigation bar
        hideNavAndToolBars(isHidden: false)

        return memedImage
    }
    
    func saveMemedImage(memedImage: UIImage) {
        
        // generate the meme
        let meme = Meme(topTextField: topTextField.text!, bottomTextField: bottomTextField.text!, originalImage: photoImageView.image!, memedImage: memedImage)
        self.meme = meme
    }
    
    @IBAction func shareMemedImage() {
        
        // generate a memed image
        let memeToShare = generateMemedImage()
        let sharingActivity = UIActivityViewController(activityItems: [memeToShare], applicationActivities: nil)
        sharingActivity.completionWithItemsHandler = { (activityType, completed, returnedItems, activityError) in
            
            if completed {
                self.saveMemedImage(memedImage: memeToShare)
            }
        }
        present(sharingActivity, animated: true, completion: nil)
    }
}


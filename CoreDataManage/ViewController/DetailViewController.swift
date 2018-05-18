//
//  ViewController.swift
//  CoreDataManage
//
//  Created by NgocAnh on 5/16/18.
//  Copyright © 2018 NgocAnh. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var index: Int?
//    var student : Student?
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        display()
    }
    // Display
    func display() {
        if index != nil{
            nameTextField.text = DataService.share.students[index!].name
            ageTextField.text = String(DataService.share.students[index!].age)
            imageView.image = DataService.share.students[index!].photo as? UIImage
        }
   
    }
    // image from library
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        imageView.image = selectedImage
        dismiss(animated: true, completion: nil)
    }
    // save data
    @IBAction func saveButton(_ sender: UIBarButtonItem) {
        if let indexPath = index {
            DataService.share.students[indexPath].name = nameTextField.text
            DataService.share.students[indexPath].age = Int32(Int(ageTextField.text ?? "") ?? 0)
            DataService.share.students[indexPath].photo = imageView.image
        } else {
            let student = Student(context: AppDelegate.context)
            student.photo = imageView.image
            student.name = nameTextField.text
            student.age = Int32(Int(ageTextField.text ?? "") ?? 0)
        }
      DataService.share.saveDataToCoreData()
        navigationController?.popToRootViewController(animated: true)
    }
//    @IBAction func saveButton(_ sender: UIBarButtonItem) {
//
//        let student = Student(context: AppDelegate.context)
//        student.name = nameTextField.text
//        student.age = Int32(Int(ageTextField.text ?? "") ?? 0)
//        student.photo = imageView.image
//       DataService.share.saveDataToCoreData()
//        navigationController?.popViewController(animated: true)
//    }
    
}


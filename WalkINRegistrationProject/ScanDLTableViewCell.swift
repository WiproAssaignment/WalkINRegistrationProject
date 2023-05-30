//
//  ScanDLTableViewCell.swift
//  WlakInRegistration
//
//  Created by Admin on 5/19/23.
//

import UIKit
protocol ScanDelegate: UIViewController {
    func showImagePicker(imagePicker: UIImagePickerController)
    func showActionSheet(alertController: UIAlertController)
    func dismissVC()
    func showThirdView(index: Int)

}
class ScanDLTableViewCell: UITableViewCell {
    let imagePicker = UIImagePickerController()
    var delegate: ScanDelegate?

    @IBOutlet weak var checkboxButton: UIButton!
    @IBOutlet weak var dashLineImageView: UIImageView!
    @IBOutlet weak var uploadImageView: UIImageView!
    @IBOutlet weak var scanbarCodeButton: UIButton!
    @IBOutlet weak var barcodeImageView: UIImageView!
    
    @IBOutlet weak var uploadFrontCopyLabel: UILabel!
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var frontCopyImageView: UIImageView!
    var buttonTag: Int = 999
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        uploadImageView.isHidden = true

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
       
    }
    func configureCamera(){
        imagePicker.sourceType = .camera
        imagePicker.delegate = self
        self.delegate?.showImagePicker(imagePicker: imagePicker)
        
    }
    
    func configurePhotos(){
        imagePicker.sourceType = .savedPhotosAlbum
        imagePicker.delegate = self
        self.delegate?.showImagePicker(imagePicker: imagePicker)
        
    }
    
    @IBAction func checkBoxButtonTapped(_ sender: UIButton) {
        if sender.tag == 0 {
            sender.tag = 1
            sender.setImage(UIImage.init(systemName: "checkmark.rectangle.fill"), for: .normal)
        } else {
            sender.setImage(UIImage.init(systemName: "checkmark.rectangle"), for: .normal)
            sender.tag = 0
        }
    }
    func configureGallery(){
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        self.delegate?.showImagePicker(imagePicker: imagePicker)
        
    }
    
    @IBAction func continueTapped(_ sender: UIButton) {
        if checkboxButton.tag == 1 {
            self.delegate?.showThirdView(index: 10)
        }
    }
    
    @IBAction func checkBoxTapped(_ sender: UIButton) {
        if sender.tag == 0 {
            sender.tag = 1
            sender.setImage(UIImage(named: ""), for: .normal)
        } else {
            sender.tag = 0
            sender.setImage(UIImage(named: ""), for: .normal)
        }
    }
    
    @IBAction func scanBarCodeButtonTapped(_ sender: UIButton) {
        buttonTag = 0
        self.showAlert()
    }
    
    @IBAction func cameraTappedTapped(_ sender: UIButton) {
        buttonTag = 1
        showAlert()
    }
    
    func showAlert() {
        let alertController = UIAlertController(title: "Alert", message: "Please choose below any option please", preferredStyle: .actionSheet)
        
        let gellary = UIAlertAction(title: "Photo Gallary", style: .default) { (action: UIAlertAction!) in
       
            self.configureGallery()
        }
        
        let camera = UIAlertAction(title: "Camera", style: .default) { (action: UIAlertAction!) in
       
            self.configureCamera()
        }
        
        let cameraRoll = UIAlertAction(title: "Camera Roll", style: .default) { (action: UIAlertAction!) in
       
            self.configurePhotos()
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

        alertController.addAction(gellary)
        alertController.addAction(camera)
        alertController.addAction(cameraRoll)
        alertController.addAction(cancel)

        self.delegate?.showActionSheet(alertController: alertController)
    }
    
    
}

extension ScanDLTableViewCell: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let photo = info[.originalImage] as? UIImage {
            
            if buttonTag == 0 {
                self.uploadImageView.isHidden = false
                self.uploadImageView.image = photo
                self.barcodeImageView.isHidden = true
                self.scanbarCodeButton.isHidden = true
            } else {
                self.frontCopyImageView.image = photo
                self.cameraButton.isHidden = true
                self.uploadFrontCopyLabel.isHidden = true
            }
        }
        self.delegate?.dismissVC()

    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.delegate?.dismissVC()
    }
}

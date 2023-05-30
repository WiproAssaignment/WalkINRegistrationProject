//
//  ProfileTableViewCell.swift
//  WalkINRegistrationProject
//
//  Created by Admin on 5/24/23.
//
 
import UIKit
protocol ProfileDelegate: AnyObject {
    func configureCameraAction()
    func segmentsAction(segmentIndex: Int)
}
class ProfileTableViewCell: UITableViewCell {
    
    var delegate: ProfileDelegate!

    @IBOutlet weak var segments: UISegmentedControl!
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var profileImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        profileImageView.layer.cornerRadius = profileImageView.frame.height / 2
        cameraButton.layer.cornerRadius = cameraButton.frame.height / 2
        segments.selectedSegmentIndex = 0
        segments.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: UIControl.State.selected)

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateProfileImage(profileImage: UIImage) {
        self.profileImageView.image = profileImage
    }
    
    @IBAction func cameraButtonTapped(_ sender: UIButton) {
        self.delegate.configureCameraAction()
    }
    
    @IBAction func segmentsTapped(_ sender: UISegmentedControl) {
        self.delegate.segmentsAction(segmentIndex: sender.selectedSegmentIndex)
    }
}

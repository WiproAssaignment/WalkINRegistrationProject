//
//  RegistrationTableViewController.swift
//  WalkINRegistrationProject
//
//  Created by Admin on 5/24/23.
//

import UIKit

protocol DropDownPickerViewdataSelectionDelegate: AnyObject {
    func showDropDownData(dataArray: [String])
    func cancelButtonTApped()
    func doneButtonAction(date: Date, index: Int)
    func registrationDropDownData(dataArray: [String])
    func registrationCancelButtonTApped()
    func registrationDoneButtonAction(date: Date, index: Int)

    func showThirdView(index: Int)
}

class RegistrationTableViewController: UITableViewController {

    var delegate: DropDownPickerViewdataSelectionDelegate!
    private var segmentsIndex: Int = 999
    private var dropDownIndex: Int = 999
    let userVisitTypeArray = ["Friend", "Parents", "Office", "General", "Friend of Friend"]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        self.tableView.register(UINib(nibName: "ProfileTableViewCell", bundle: nil), forCellReuseIdentifier: "ProfileTableViewCell")
        self.tableView.register(UINib(nibName: "DataTableViewCell", bundle: nil), forCellReuseIdentifier: "DataTableViewCell")
        self.tableView.register(UINib(nibName: "ScanDLTableViewCell", bundle: nil), forCellReuseIdentifier: "ScanDLTableViewCell")
        self.tableView.register(UINib(nibName: "RegistrationTableViewCell", bundle: nil), forCellReuseIdentifier: "RegistrationTableViewCell")

    }
    
    func configureImagePicker() {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        self.navigationController?.present(imagePicker, animated: true)
    }
    
    func updateUI(name: String, index: Int) {
        let indexPath = IndexPath(row: 1, section: 0)
        if index == 100 {
            let cell = self.tableView.cellForRow(at: indexPath) as! DataTableViewCell
            if dropDownIndex == 0 {
               cell.visitorTypeTF.text = name
            } else if dropDownIndex == 1 {
                cell.purposeTF.text = name
            } else {
                cell.siteTF.text = name
            }
        } else {
            let cell = self.tableView.cellForRow(at: indexPath) as! RegistrationTableViewCell
            if dropDownIndex == 0 {
               cell.visitorTypeTF.text = name
            } else if dropDownIndex == 1 {
                cell.purposeTF.text = name
            } else {
                cell.siteTF.text = name
            }
        }
       
    }
    
    func updateUI(dateStr: String, index: Int, cellIndex: Int) {
        let indexPath = IndexPath(row: 1, section: 0)
        
        if cellIndex == 100 {
            let cell = self.tableView.cellForRow(at: indexPath) as! DataTableViewCell
            if index == 0 {
               cell.firstDateTF.text = dateStr

            } else {
               cell.secondDateTF.text = dateStr

            }
        } else {
            let cell = self.tableView.cellForRow(at: indexPath) as! RegistrationTableViewCell
            if index == 0 {
               cell.firstDateTF.text = dateStr

            } else {
               cell.secondDateTF.text = dateStr

            }
        }

        
    }
    
    func updateUI(index: Int) {
        segmentsIndex = index
        self.tableView.reloadData()
    }
    
    
    func updateProfileImage(image: UIImage) {
        
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = self.tableView.cellForRow(at: indexPath) as! ProfileTableViewCell
        cell.updateProfileImage(profileImage: image)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 2
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        // Configure the cell...
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileTableViewCell", for: indexPath) as! ProfileTableViewCell
            cell.delegate = self
            return cell

        } else {
            if segmentsIndex == 0 || segmentsIndex == 999 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "DataTableViewCell", for: indexPath) as! DataTableViewCell
                cell.delegate = self
                return cell

            } else {
                if segmentsIndex == 900 {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "RegistrationTableViewCell", for: indexPath) as! RegistrationTableViewCell
                    cell.delegate = self
                    return cell

                } else {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "ScanDLTableViewCell", for: indexPath) as! ScanDLTableViewCell
                    cell.delegate = self
                    return cell
                }

            }

        }

    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 250
        } else {
            
            if segmentsIndex == 0 || segmentsIndex == 999 {
                return 1000
            } else {
                if segmentsIndex == 900 {
                    return 1200
                } else {
                    return 560
                }
            }
        }
    }

}

extension RegistrationTableViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let photo = info[.originalImage] as? UIImage {
            self.updateProfileImage(image: photo)
        }
        self.dismiss(animated: true)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true)
    }
    
}

extension RegistrationTableViewController: ProfileDelegate {
    func configureCameraAction() {
        self.configureImagePicker()
    }
    
    func segmentsAction(segmentIndex: Int) {
        self.updateUI(index: segmentIndex)
    }
}

extension RegistrationTableViewController: DropDownDelegate {
    func dropDownAction(button: UIButton) {
        self.dropDownIndex = button.tag
        if button.tag == 0 {
            self.delegate.showDropDownData(dataArray: userVisitTypeArray)
        } else if button.tag == 1 {
            self.delegate.showDropDownData(dataArray: userVisitTypeArray)
        } else {
            self.delegate.showDropDownData(dataArray: userVisitTypeArray)
        }
    }
    
    func cancelTapped() {
        self.delegate.cancelButtonTApped()
    }
    
    func doneTapped(date: Date, tag: Int) {
        self.delegate.doneButtonAction(date: date, index: tag)
    }
    
    
}

extension RegistrationTableViewController: ScanDelegate {
    func showThirdView(index: Int) {
        self.delegate.showThirdView(index: index)
    }

    func showImagePicker(imagePicker: UIImagePickerController) {
        self.navigationController?.present(imagePicker, animated: true)

    }

    func showActionSheet(alertController: UIAlertController) {
        self.navigationController?.present(alertController, animated: true)
    }

    func dismissVC() {
        self.dismiss(animated: true)
    }


}

extension RegistrationTableViewController: RegistrationDropDownDelegate {
    func registrationDropDownAction(button: UIButton) {
        self.dropDownIndex = button.tag
        if button.tag == 0 {
            self.delegate.registrationDropDownData(dataArray: userVisitTypeArray)
        } else if button.tag == 1 {
            self.delegate.registrationDropDownData(dataArray: userVisitTypeArray)
        } else {
            self.delegate.registrationDropDownData(dataArray: userVisitTypeArray)
        }
    }
    
    func registrationCancelTapped() {
        self.delegate.registrationCancelButtonTApped()
    }
    
    func registrationDoneTapped(date: Date, tag: Int) {
        self.delegate.registrationDoneButtonAction(date: date, index: tag)
    }
}

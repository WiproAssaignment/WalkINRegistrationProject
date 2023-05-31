//
//  DataTableViewCell.swift
//  WlakInRegistration
//
//  Created by Admin on 5/18/23.
//
  
import UIKit
protocol RegistrationDropDownDelegate: UIViewController {
    func registrationDropDownAction(button: UIButton)
    func registrationCancelTapped()
    func registrationDoneTapped(date: Date, tag: Int)

}
  
class RegistrationTableViewCell: UITableViewCell {
    
    var delegate: RegistrationDropDownDelegate?
   
    @IBOutlet weak var datePickerView: UIView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var label91: UILabel!
  
    @IBOutlet weak var lastNameView: UIView!
    @IBOutlet weak var firstnameView: UIView!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var lastNameTF: UITextField!
    @IBOutlet weak var firstNamrTF: UITextField!
    @IBOutlet weak var view91: UIView!
    @IBOutlet weak var phoneView: UIView!
    @IBOutlet weak var phoneTF: UITextField!
    @IBOutlet weak var visitorTypeView: UIView!
    @IBOutlet weak var visitorTypeTF: UITextField!
    @IBOutlet weak var purposeTF: UITextField!
    @IBOutlet weak var purposeView: UIView!
    @IBOutlet weak var purposeEntryView: UIView!
    @IBOutlet weak var purposeEntryTF: UITextField!
    @IBOutlet weak var companyNameView: UIView!
    @IBOutlet weak var companyNameTF: UITextField!
    @IBOutlet weak var siteView: UIView!
    @IBOutlet weak var siteTF: UITextField!
    @IBOutlet weak var firstCalenderView: UIView!
    @IBOutlet weak var firstDateTF: UITextField!
    @IBOutlet weak var secondCalenderView: UIView!
    @IBOutlet weak var secondDateTF: UITextField!
    @IBOutlet weak var remarksView: UIView!
    @IBOutlet weak var remarksTF: UITextField!
    
    var dateTag: Int = 999
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        configureBorders(view: firstnameView)
        configureBorders(view: lastNameView)
        configureBorders(view: emailView)
        configureBorders(view: view91)
        configureBorders(view: phoneView)
        configureBorders(view: visitorTypeView)
        configureBorders(view: purposeView)
        configureBorders(view: purposeEntryView)
        configureBorders(view: companyNameView)
        configureBorders(view: siteView)
        configureBorders(view: firstCalenderView)
        configureBorders(view: secondCalenderView)
        configureBorders(view: remarksView)

        
        getAttributedString(text: "First Name ", textField: firstNamrTF)
        getAttributedString(text: "Email ", textField: emailTF)
        getAttributedString(text: "Phone ", textField: phoneTF)
        getAttributedString(text: "VisitorType ", textField: visitorTypeTF)
        getAttributedString(text: "Purpose ", textField: purposeTF)
        getAttributedString(text: "Company Name ", textField: companyNameTF)
        getAttributedString(text: "site ", textField: siteTF)
        
        datePickerView.isHidden = true


    }
    
    func updateUI() {
        emailTF.text =  ""
        purposeTF.text = ""
        siteTF.text = ""
        secondDateTF.text = ""
        visitorTypeTF.text = ""
        phoneTF.text = ""
        remarksTF.text = ""
        lastNameTF.text = ""
        firstDateTF.text = ""
        firstNamrTF.text = ""
        companyNameTF.text = ""
        purposeEntryTF.text = ""
    }
    
    func configureBorders(view: UIView) {
        view.layer.cornerRadius = 5.0
        view.layer.borderWidth = 1.0
        view.layer.borderColor = UIColor.gray.cgColor

    }
  
    
    func getAttributedString(text: String, textField: UITextField) {
        let starMark = NSAttributedString(string: "*", attributes: [.foregroundColor: UIColor.red])
        let mobileAtrributedString = NSMutableAttributedString(string: text)
        mobileAtrributedString.append(starMark)
        textField.attributedPlaceholder = mobileAtrributedString

    }
  
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
   
    @IBAction func indiaButtonTapped(_ sender: UIButton) {
        self.delegate?.registrationDropDownAction(button: sender)
    }
    
    @IBAction func visitorDropDownTapped(_ sender: UIButton) {
        
        self.delegate?.registrationDropDownAction(button: sender)
    }
    
    @IBAction func purposeDropDownTapped(_ sender: UIButton) {
        self.delegate?.registrationDropDownAction(button: sender)

    }
    
    @IBAction func siteDropDownTapped(_ sender: UIButton) {
        self.delegate?.registrationDropDownAction(button: sender)

    }
    
    @IBAction func firstCalenderTapped(_ sender: UIButton) {
        self.dateTag = 0
        self.datePickerView.isHidden = false
    }
    
    @IBAction func secondCalenderTapped(_ sender: UIButton) {
        self.dateTag = 1
        self.datePickerView.isHidden = false
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        self.datePickerView.isHidden = true
    }
    
    @IBAction func doneButtonTapped(_ sender: UIButton) {
        self.datePickerView.isHidden = true
        self.delegate?.registrationDoneTapped(date: datePicker.date, tag: self.dateTag)
    }
}

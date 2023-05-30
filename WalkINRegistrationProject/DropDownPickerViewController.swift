//
//  DropDownPickerViewController.swift
//  WalkINRegistrationProject
//
//  Created by Admin on 5/30/23.
//

import UIKit

protocol ShowDropDownSelection: AnyObject {
    func showDropDown(name: String)
    func cancelAction()
}
class DropDownPickerViewController: UIViewController {
    @IBOutlet weak var pickerView: UIPickerView!
    var delegate: ShowDropDownSelection!
    var dataArray: [String] = []
    var dataselectionIndex: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.delegate = self
        pickerView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    func configurePickerView(inputArray: [String]) {
        dataArray = inputArray
        pickerView.reloadAllComponents()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func doneButtonTapped(_ sender: UIButton) {
        self.delegate.showDropDown(name: dataArray[dataselectionIndex])
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        self.delegate.cancelAction()
    }
}

extension DropDownPickerViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return dataArray[row]
    }
    
}

extension DropDownPickerViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.dataselectionIndex = row
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 30
    }
}

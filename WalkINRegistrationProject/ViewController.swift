//
//  ViewController.swift
//  WalkINRegistrationProject
//
//  Created by Admin on 5/24/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var registrationContainerView: UIView!
    
    @IBOutlet weak var dropDownContainerView: UIView!
    var selectedCellIndex: Int = 999
    private lazy var registrationTableViewController: RegistrationTableViewController = {
        // Load Storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)

        // Instantiate View Controller
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "RegistrationTableViewController") as? RegistrationTableViewController else {
            fatalError("Unable to Instantiate Sessions View Controller")
        }
        viewController.delegate = self

        // Add View Controller as Child View Controller
        self.add(asChildViewController: viewController, view: registrationContainerView)
        return viewController
    }()
    
    private lazy var dropDownPickerViewController: DropDownPickerViewController = {
        // Load Storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)

        // Instantiate View Controller
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "DropDownPickerViewController") as? DropDownPickerViewController else {
            fatalError("Unable to Instantiate Sessions View Controller")
        }
        self.add(asChildViewController: viewController, view: dropDownContainerView)
        viewController.delegate = self
        // Add View Controller as Child View Controller
        return viewController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpNavigationBar()
        self.dropDownContainerView.isHidden = true
        add(asChildViewController: registrationTableViewController, view: registrationContainerView)
    }
    
    func setUpNavigationBar() {
        self.navigationController?.isNavigationBarHidden = false
       // self.title = "Walk-In Registration"
        let backButton = UIBarButtonItem(image: UIImage.init(systemName: "arrow.backward.square"), style: .plain, target: self, action: #selector(backButtonTapped))
        let titleLabel = UIBarButtonItem(title: "Add Walk-In Registration", style: .plain, target: self, action: nil)
        self.navigationItem.leftBarButtonItems = [backButton, titleLabel]
        
    }
    
    @objc func backButtonTapped() {
        
    }
    
    private func add(asChildViewController viewController: UIViewController, view: UIView) {
        // Add Child View Controller
        addChild(viewController)

        // Add Child View as Subview
        view.addSubview(viewController.view)
        
        // Notify Child View Controller
        viewController.didMove(toParent: self)
    }
    
    private func remove(asChildViewController viewController: UIViewController) {
        // Notify Child View Controller
        viewController.willMove(toParent: nil)

        // Remove Child View From Superview
        viewController.view.removeFromSuperview()

        // Notify Child View Controller
        viewController.removeFromParent()
    }

}

extension ViewController: DropDownPickerViewdataSelectionDelegate {
    func registrationDropDownData(dataArray: [String]) {
        self.selectedCellIndex = 101
        self.dropDownContainerView.isHidden = false
        self.add(asChildViewController: dropDownPickerViewController, view: dropDownContainerView)
        self.dropDownPickerViewController.configurePickerView(inputArray: dataArray)
    }
    
    func registrationCancelButtonTApped() {
        
    }
    
    func registrationDoneButtonAction(date: Date, index: Int) {
        let formatter = DateFormatter()
            formatter.dateFormat = "dd/MM/yy h:mm a"
        let str =  formatter.string(from: date)
        self.registrationTableViewController.updateUI(dateStr: str, index: index, cellIndex: 101)

    }
    
    func showThirdView(index: Int) {
        self.registrationTableViewController.updateUI(index: 900)
    }
    
    func cancelButtonTApped() {
        
    }
    
    func doneButtonAction(date: Date, index: Int) {
        self.selectedCellIndex = 100
        let formatter = DateFormatter()
            formatter.dateFormat = "dd/MM/yy h:mm a"
        let str =  formatter.string(from: date)
        self.registrationTableViewController.updateUI(dateStr: str, index: index, cellIndex: 100)
    }
    
    func showDropDownData(dataArray: [String]) {
        self.selectedCellIndex = 100
        self.dropDownContainerView.isHidden = false
        self.add(asChildViewController: dropDownPickerViewController, view: dropDownContainerView)
        self.dropDownPickerViewController.configurePickerView(inputArray: dataArray)
    }
    
}

extension ViewController: ShowDropDownSelection {
    func cancelAction() {
        self.remove(asChildViewController: dropDownPickerViewController)
        self.dropDownContainerView.isHidden = true
    }
    
    func showDropDown(name: String) {
        self.remove(asChildViewController: dropDownPickerViewController)
        self.dropDownContainerView.isHidden = true
        self.registrationTableViewController.updateUI(name: name, index: selectedCellIndex)
        
    }
    
}


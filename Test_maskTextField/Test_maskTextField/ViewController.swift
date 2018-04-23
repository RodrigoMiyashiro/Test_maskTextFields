//
//  ViewController.swift
//  Test_maskTextField
//
//  Created by Rodrigo Miyashiro on 14/04/2018.
//  Copyright © 2018 Rodrigo Miyashiro. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    
    // MARK: - IBOutlets
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var cellPhoneTextField: UITextField!
    @IBOutlet weak var cpfTextField: UITextField!
    @IBOutlet weak var cnpjTextField: UITextField!
    @IBOutlet weak var cepTextField: UITextField!
    
    

    override func viewDidLoad()
    {
        super.viewDidLoad()

        priceTextField.placeholder = Mask.updatePriceAmount(amt: 0)
        dateTextField.placeholder = Mask.updateDate(date: Date())
        phoneTextField.placeholder = "(00) 0000-0000"
        cellPhoneTextField.placeholder = "(00) 0 0000-0000"
        cpfTextField.placeholder = "000.000.000-00" //formatCPFNumber(0)
        cnpjTextField.placeholder = "00.000.000/0001-00"
        cepTextField.placeholder = "00.000-000"
    }

}


extension ViewController: UITextFieldDelegate
{
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        view.endEditing(true)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        if textField == dateTextField
        {
            datePicker(textField: textField)
            self.datePickerToolBar(textField: textField)
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        if textField == priceTextField
        {
            textField.text =  Mask.maskPrice(textField: textField, string: string)
        }
        
        if textField == phoneTextField
        {
            textField.text = Mask.maskPhone(textField: textField, string: string)
        }
        
        if textField == cellPhoneTextField
        {
            textField.text = Mask.maskPhone(textField: textField, string: string)
        }
        
        if textField == cpfTextField
        {
            textField.text = Mask.maskCPF(textField: textField, string: string)
        }
        
        if textField == cnpjTextField
        {
            textField.text = Mask.maskCNPJ(textField: textField, string: string)
        }
        
        if textField == cepTextField
        {
//            textField.text = 
        }
        
        return false
    }
    
    // MARK: DatePicker Toolbar
    func datePickerToolBar(textField: UITextField)
    {
        let toolBar = UIToolbar(frame:CGRect(x: 0, y: self.view.frame.size.height/6, width: self.view.frame.size.width, height: 40.0))
        toolBar.layer.position = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height-20.0)
        toolBar.barStyle = UIBarStyle.blackTranslucent
        toolBar.tintColor = UIColor.white
        toolBar.backgroundColor = UIColor.black
        
        
        let todayBtn = UIBarButtonItem(title: "Hoje", style: UIBarButtonItemStyle.plain, target: self, action: #selector(tappedToolBarBtn(sender:)))
        let okBarBtn = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(donePressed(sender:)))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: nil)
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width / 3, height: self.view.frame.size.height))
        label.font = UIFont(name: "Helvetica", size: 12)
        label.backgroundColor = UIColor.clear
        label.textColor = UIColor.white
        label.text = "Selecione uma data"
        label.textAlignment = NSTextAlignment.center
        
        let textBtn = UIBarButtonItem(customView: label)
        toolBar.setItems([todayBtn,flexSpace,textBtn,flexSpace,okBarBtn], animated: true)
        
        textField.inputAccessoryView = toolBar
    }
    
    @objc func donePressed(sender: UIBarButtonItem)
    {
        dateTextField.resignFirstResponder()
    }
    
    @objc func tappedToolBarBtn(sender: UIBarButtonItem)
    {
        let dateformatter = DateFormatter()
        dateformatter.dateStyle = DateFormatter.Style.medium
        dateformatter.timeStyle = DateFormatter.Style.none
        dateTextField.text = Mask.updateDate(date: Date())//dateformatter.string(from: NSDate() as Date)
        dateTextField.resignFirstResponder()
    }
    
    @objc func datePicker(textField: UITextField)
    {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(datePickerValueChange(sender:)), for: UIControlEvents.valueChanged)
        textField.inputView = datePicker
    }
    
    @objc func datePickerValueChange(sender: UIDatePicker)
    {
        let date = Mask.updateDate(date: sender.date)
        self.dateTextField.text = date ?? Mask.updateDate(date: Date())
    }
}

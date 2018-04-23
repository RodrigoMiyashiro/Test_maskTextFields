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
    
    

    override func viewDidLoad()
    {
        super.viewDidLoad()

        priceTextField.placeholder = updatePriceAmount(amt: 0)
        dateTextField.placeholder = updateDate(date: Date())
        cpfTextField.placeholder = formatCPFNumber(0)
        cnpjTextField.placeholder = "00.000.000/0001-00"
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
            textField.text =  maskPrice(textField: textField, string: string)
        }
        
//        if textField == dateTextField
//        {
//
//        }
        
        if textField == phoneTextField
        {
            
        }
        
        if textField == cellPhoneTextField
        {
            
        }
        
        if textField == cpfTextField
        {
            textField.text = maskCPF(textField: textField, string: string)
        }
        
        if textField == cnpjTextField
        {
            textField.text = maskCNPJ(textField: textField, string: string)
        }
        
        return false
    }
    
    
    // MARK: - MASKS
    // Price
    func maskPrice(textField: UITextField, string: String) -> String
    {
        var amt: Int = 0
        if let digit = Int(string)
        {
            amt = (removeCharacters(value: textField.text!) ?? 0) * 10 + digit
            
            if amt > 1_000_000_000_00
            {
                return textField.text ?? "0"
            }

            return updatePriceAmount(amt: amt)!
        }
        if string == ""
        {
            amt = (removeCharacters(value: textField.text!) ?? 0) / 10
            return amt == 0 ? "" : updatePriceAmount(amt: amt)!
        }
        
        return textField.text ?? "0"
    }
    
    // CPF
    func maskCPF(textField: UITextField, string: String) -> String
    {
        var amt: Int = 0
        if let digit = Int(string)
        {
            amt = (removeCharacters(value: textField.text!) ?? 0) * 10 + digit
            
            if amt > 999_999_999_99
            {
                return textField.text ?? "0"
            }
            
            return formatCPFNumber(amt)!
        }
        if string == ""
        {
            amt = (removeCharacters(value: textField.text!) ?? 0) / 10
            return amt == 0 ? "" : formatCPFNumber(amt)!
        }
        
        return textField.text ?? "0"
    }
    
    
    // CNPJ
    func maskCNPJ(textField: UITextField, string: String) -> String
    {
        var amt: Int = 0
        if let digit = Int(string)
        {
            amt = (removeCharacters(value: textField.text!) ?? 0) * 10 + digit
            
            if amt > 99_999_999_9999_99
            {
                return textField.text ?? "0"
            }
            
            return formatCNPJNumber(amt)!
        }
        if string == ""
        {
            amt = (removeCharacters(value: textField.text!) ?? 0) / 10
            return amt == 0 ? "" : formatCNPJNumber(amt)!
        }
        
        return textField.text ?? "0"
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
        let date = updateDate(date: sender.date)
        self.dateTextField.text = date ?? updateDate(date: Date())
    }
    
    
    
    
    
    // MARK: Utils
    func removeCharacters(value: String) -> Int?
    {
        return Int(value.replacingOccurrences(of: "R$", with: "").replacingOccurrences(of: "$", with: "").replacingOccurrences(of: ",", with: "").replacingOccurrences(of: ".", with: "").replacingOccurrences(of: "/", with: "").replacingOccurrences(of: "-", with: "").replacingOccurrences(of: "(", with: "").replacingOccurrences(of: ")", with: ""))
    }
    
    func updatePriceAmount(amt: Int) -> String?
    {
        let formatter = NumberFormatter()
        formatter.numberStyle = NumberFormatter.Style.currency
        formatter.locale = Locale(identifier: "pt_BR")
        let amount = Double(amt / 100) + Double(amt % 100) / 100
        
        return formatter.string(from: NSNumber(value: amount))
    }
    
    
    // CPF
    func formatCPFNumber(_ number: Int) -> String?
    {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.currencySymbol = ""
        formatter.groupingSeparator = "."
        formatter.decimalSeparator = "-"
        let amount = Double(number / 100) + Double(number % 100) / 100
        
        return formatter.string(from: NSNumber(value: amount))
    }
    
    
    // CNPJ
    func formatCNPJNumber(_ number: Int) -> String?
    {
//        let formatter = NumberFormatter()
//        formatter.numberStyle = .decimal
//        formatter.currencySymbol = ""
//        formatter.groupingSeparator = ""
//        formatter.decimalSeparator = "-"
//        let amount = Double(number / 100) + Double(number % 100) / 100
//
//        print("-->> \(Double(number / 1000)) + \(Double(number % 100) / 100) = \(amount)")
//        return formatter.string(from: NSNumber(value: amount))
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.currencySymbol = ""
        formatter.groupingSeparator = ""
        formatter.decimalSeparator = "-"
        let amount = Double(number / 1000) + Double(number % 1000) / 1000
        
        print("-->> \(Double(number / 1000)) + \(Double(number % 1000) / 1000) = \(amount)")
        return formatter.string(from: NSNumber(value: amount))
    }
    
    
    // MARK: UpdateDate
    func updateDate(date: Date) -> String?
    {
        let dateFormatter = DateFormatter()
//        dateFormatter.dateStyle = "dd/MM/yyyy" //.short
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        return dateFormatter.string(from: date)
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
        dateTextField.text = updateDate(date: Date())//dateformatter.string(from: NSDate() as Date)
        dateTextField.resignFirstResponder()
    }
    
}

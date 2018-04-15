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

        priceTextField.placeholder = updateAmount(amt: 0)
    }

}


extension ViewController: UITextFieldDelegate
{
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        view.endEditing(true)
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        var amt: Int = 0
        if let digit = Int(string)
        {
            amt = (removeCharacters(value: textField.text!) ?? 0) * 10 + digit
            
            if amt > 1_000_000_000_00
            {
                return false
            }
            
            priceTextField.text = updateAmount(amt: amt)
        }
        if string == ""
        {
            amt = (removeCharacters(value: textField.text!) ?? 0) / 10
            priceTextField.text = amt == 0 ? "" : updateAmount(amt: amt)
        }
        
        return false
    }
    
    func removeCharacters(value: String) -> Int?
    {
        return Int(value.replacingOccurrences(of: "R$", with: "").replacingOccurrences(of: "$", with: "").replacingOccurrences(of: ",", with: "").replacingOccurrences(of: ".", with: ""))
    }
    
    func updateAmount(amt: Int) -> String?
    {
        let formatter = NumberFormatter()
        formatter.numberStyle = NumberFormatter.Style.currency
        let amount = Double(amt / 100) + Double(amt % 100) / 100
        
        return formatter.string(from: NSNumber(value: amount))
    }
    
}

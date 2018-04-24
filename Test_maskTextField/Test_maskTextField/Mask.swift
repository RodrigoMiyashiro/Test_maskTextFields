//
//  String.swift
//  Test_maskTextField
//
//  Created by Rodrigo Miyashiro on 14/04/2018.
//  Copyright © 2018 Rodrigo Miyashiro. All rights reserved.
//

import UIKit
import Foundation

class Mask
{
    // MARK: - MASKS
    // Price
    static func maskPrice(textField: UITextField, string: String) -> String
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
    static func maskCPF(textField: UITextField, string: String) -> String
    {
        var amt: String = ""
        if let _ = Int(string)
        {
            amt = getStringClear(value: textField.text!)! + string
            
            if amt.count > 11
            {
                return textField.text ?? "0"
            }
            
            return formatCPFNumber(amt)!
        }
        if string == ""
        {
            amt = removeLastCharater(value: textField.text!) ?? ""
            return amt == "" ? "" : formatCPFNumber(amt)!
        }
        
        return textField.text ?? "0"
    }
    
    
    // CNPJ
    static func maskCNPJ(textField: UITextField, string: String) -> String
    {
        var amt: String = ""
        if let _ = Int(string)
        {
            amt = getStringClear(value: textField.text!)! + string
            
            if amt.count > 14
            {
                return textField.text ?? "0"
            }
            
            return formatCNPJNumber(number: amt)!
        }
        if string == ""
        {
            amt = removeLastCharater(value: textField.text!) ?? ""
            return amt == "" ? "" : formatCNPJNumber(number: amt)!
        }
        
        return textField.text ?? "0"
    }
    
    
    // Phone
    static func maskPhone(textField: UITextField, string: String) -> String
    {
        var amt: String = ""
        if let _ = Int(string)
        {
            amt = getStringClear(value: textField.text!)! + string
            
            if amt.count > 11
            {
                return textField.text ?? "0"
            }
            
            return formatPhone(number: amt)!
        }
        if string == ""
        {
            amt = removeLastCharater(value: textField.text!) ?? ""
            return amt == "" ? "" : formatPhone(number: amt)!
        }
        
        return textField.text ?? "0"
    }
    
    // CEP
    static func maskCEP(textField: UITextField, string: String) -> String
    {
        var amt: String = ""
        if let _ = Int(string)
        {
            amt = getStringClear(value: textField.text!)! + string
            
            if amt.count > 8
            {
                return textField.text ?? "0"
            }
            
            return formatCEP(number: amt)!
        }
        if string == ""
        {
            amt = removeLastCharater(value: textField.text!) ?? ""
            return amt == "" ? "" : formatCEP(number: amt)!
        }
        
        return textField.text ?? "0"
    }

    
    // MARK: Utils
    static func removeCharacters(value: String) -> Int?
    {
        return Int(value.replacingOccurrences(of: "R$", with: "").replacingOccurrences(of: "$", with: "").replacingOccurrences(of: ",", with: "").replacingOccurrences(of: ".", with: "").replacingOccurrences(of: "/", with: "").replacingOccurrences(of: "-", with: "").replacingOccurrences(of: "(", with: "").replacingOccurrences(of: ")", with: "").replacingOccurrences(of: " ", with: ""))
    }
    
    static func getStringClear(value: String) -> String?
    {
        return value.replacingOccurrences(of: "R$", with: "").replacingOccurrences(of: "$", with: "").replacingOccurrences(of: ",", with: "").replacingOccurrences(of: ".", with: "").replacingOccurrences(of: "/", with: "").replacingOccurrences(of: "-", with: "").replacingOccurrences(of: "(", with: "").replacingOccurrences(of: ")", with: "").replacingOccurrences(of: " ", with: "")
    }
    
    static func removeLastCharater(value: String) -> String?
    {
        var strArray = Array(getStringClear(value: value)!)
        strArray.removeLast()
        
        return strArray.map({"\($0)"}).joined(separator: "")
    }
    
    static func updatePriceAmount(amt: Int) -> String?
    {
        let formatter = NumberFormatter()
        formatter.numberStyle = NumberFormatter.Style.currency
        formatter.locale = Locale(identifier: "pt_BR")
        let amount = Double(amt / 100) + Double(amt % 100) / 100
        
        return formatter.string(from: NSNumber(value: amount))
    }
    
    
    // CPF
    static func formatCPFNumber(_ number: String) -> String?
    {
        var strNumber = number
        
        if strNumber.count > 9
        {
            strNumber.insert("-", at: String.Index.init(encodedOffset: 9))
        }
        if strNumber.count > 6
        {
            strNumber.insert(".", at: String.Index.init(encodedOffset: 6))
        }
        if strNumber.count > 3
        {
            strNumber.insert(".", at: String.Index.init(encodedOffset: 3))
        }
        
        return strNumber
    }
    
    
    // CNPJ
    static func formatCNPJNumber(number: String) -> String?
    {
        var strNumber = number
        
        if strNumber.count > 12
        {
            strNumber.insert("-", at: String.Index.init(encodedOffset: 12))
        }
        if strNumber.count > 8
        {
            strNumber.insert("/", at: String.Index.init(encodedOffset: 8))
        }
        if strNumber.count > 5
        {
            strNumber.insert(".", at: String.Index.init(encodedOffset: 5))
        }
        if strNumber.count > 1
        {
            strNumber.insert(".", at: String.Index.init(encodedOffset: 2))
        }
        
        return strNumber
    }
    
    
    // Phone
    static func formatPhone(number: String) -> String?
    {
        var strNumber = number
        
        if strNumber.count > 10
        {
            strNumber.insert("(", at: String.Index.init(encodedOffset: 0))
            strNumber.insert(")", at: String.Index.init(encodedOffset: 3))
            strNumber.insert(" ", at: String.Index.init(encodedOffset: 4))
            strNumber.insert(" ", at: String.Index.init(encodedOffset: 6))
            strNumber.insert("-", at: String.Index.init(encodedOffset: 11))
        }
        else
        {
            if strNumber.count > 7
            {
                strNumber.insert("-", at: String.Index.init(encodedOffset: 6))
            }
            if strNumber.count > 3
            {
                strNumber.insert(")", at: String.Index.init(encodedOffset: 2))
                strNumber.insert(" ", at: String.Index.init(encodedOffset: 3))
            }
            if strNumber.count >= 0
            {
                strNumber.insert("(", at: String.Index.init(encodedOffset: 0))
            }
        }
        
        return strNumber
    }
    
    // CEP
    static func formatCEP(number: String) -> String?
    {
        var strNumber = number
        
        if strNumber.count > 5
        {
            strNumber.insert("-", at: String.Index.init(encodedOffset: 5))
        }
        if strNumber.count > 2
        {
            strNumber.insert(".", at: String.Index.init(encodedOffset: 2))
        }
        
        return strNumber
    }
    
    // MARK: UpdateDate
    static func updateDate(date: Date) -> String?
    {
        let dateFormatter = DateFormatter()
        //        dateFormatter.dateStyle = "dd/MM/yyyy" //.short
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        return dateFormatter.string(from: date)
    }
    
}

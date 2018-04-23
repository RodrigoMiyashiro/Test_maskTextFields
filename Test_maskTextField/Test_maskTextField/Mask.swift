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
        var amt: Int = 0
        if let digit = Int(string)
        {
            amt = (removeCharacters(value: textField.text!) ?? 0) * 10 + digit
            
            print("-->> \(String((removeCharacters(value: textField.text!) ?? 0) * 10) + string)")
            
            if amt > 1_000_000_000_00
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
    static func maskCNPJ(textField: UITextField, string: String) -> String
    {
        var amt: Int = 0
        if let digit = Int(string)
        {
            amt = (removeCharacters(value: textField.text!) ?? 0) * 10 + digit
            
            if amt > 100_000_000_000_000
            {
                return textField.text ?? "0"
            }
            
            return formatCNPJNumber(number: String(amt))!
        }
        if string == ""
        {
            amt = (removeCharacters(value: textField.text!) ?? 0) / 10
            return amt == 0 ? "" : formatCNPJNumber(number: String(amt))!
        }
        
        return textField.text ?? "0"
    }
    
    
    // Phone
    static func maskPhone(textField: UITextField, string: String) -> String
    {
        var amt: Int = 0
        if let digit = Int(string)
        {
            amt = (removeCharacters(value: textField.text!) ?? 0) * 10 + digit
            if amt > 100_000_000_000
            {
                return textField.text ?? ""
            }
            
            return formatPhone(number: String(amt))!
        }
        if string == ""
        {
            amt = (removeCharacters(value: textField.text!) ?? 0) / 10
            return amt == 0 ? "" : formatPhone(number: String(amt))!
        }
        
        return textField.text ?? "0"
    }

    
    // MARK: Utils
    static func removeCharacters(value: String) -> Int?
    {
        return Int(value.replacingOccurrences(of: "R$", with: "").replacingOccurrences(of: "$", with: "").replacingOccurrences(of: ",", with: "").replacingOccurrences(of: ".", with: "").replacingOccurrences(of: "/", with: "").replacingOccurrences(of: "-", with: "").replacingOccurrences(of: "(", with: "").replacingOccurrences(of: ")", with: "").replacingOccurrences(of: " ", with: ""))
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
    static func formatCPFNumber(_ number: Int) -> String?
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
    
    // MARK: UpdateDate
    static func updateDate(date: Date) -> String?
    {
        let dateFormatter = DateFormatter()
        //        dateFormatter.dateStyle = "dd/MM/yyyy" //.short
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        return dateFormatter.string(from: date)
    }
    
}

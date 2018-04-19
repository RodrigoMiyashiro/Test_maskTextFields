//
//  FormatText.swift
//  CaixaSeguradora
//
//  Created by Danilo Bias Lago on 20/10/15.
//  Copyright © 2015 Kanamobi. All rights reserved.
//

import Foundation

class FormatText: NSObject {
    
    class func formatCPFNumber(_ cpf: String, backSpace: Bool) -> String {
        if backSpace == false {
            if cpf.length == 3 || cpf.length == 7 {
                return cpf + "."
            }else if cpf.length == 11 {
                return cpf + "-"
            }
        }
        return cpf
    }
    
    class func formatPrice(_ text: String) -> String{
        
        let formatter = NumberFormatter()
        formatter.numberStyle = NumberFormatter.Style.decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 12
        formatter.locale = Locale(identifier: "pt_BR")
        
        let valueString = NSString(string: text).replacingOccurrences(of: formatter.currencySymbol, with: "") as NSString
        
        let valueNumber = formatter.number(from: valueString as String)!
        
        formatter.locale = Locale(identifier: "en_US")
        
        let value = formatter.string(from: valueNumber)!.replacingOccurrences(of: ",", with: "") as NSString
        
        return value as String
    }

    
    class func removeCPFFormat(_ cpf: String) -> String {
        return cpf.replacingOccurrences(of: ".", with: "").replacingOccurrences(of: "-", with:"")
    }
    
    class func formatCellPhoneNumber(_ string: String, backSpace: Bool) -> String {
        
        if !backSpace {
            
            if (string.length == 0) {
            
                return string + "("
                
            }else
                if (string.length == 1) {
                
                return string
                
            } else if (string.length == 3) {

                return string + ")"
                
//            } else if (string.length == 4) {
//
//                return string.stringByAppendingString(" ")

            } else if (string.length == 8) {

                return string + "-"

            } else if (string.length == 13) {
                
                let newString = string.replacingOccurrences(of: "-", with: "")
                
                let mutableString = NSMutableString(string: newString)
                mutableString.insert("-", at: 9)
                
                return mutableString as String
            }

            
        } else {

            if string.length == 14 {
                
                let newString = string.replacingOccurrences(of: "-", with: "")
                
                let mutableString = NSMutableString(string: newString)
                mutableString.insert("-", at: 8)
                
                return mutableString as String

            }
        }
        
        return string
    }
    
    class func formatTimeIntervalToDate(_ intervalBetweenDates: Double) -> String {
        let interval = intervalBetweenDates
        var minutes = (interval / 60).truncatingRemainder(dividingBy: 60)
        var hours = (interval / 3600)
        
        if round(minutes) == 60 {
            minutes = 0
            hours += 1
        }
        
        return String(format: "%02d:%02d", Int(hours), Int(round(minutes)))
    }
    
    class func formatHours(_ hours: Float) -> String {
        let hoursWithoutFormat = Double(hours * 3600)
        return FormatText.formatTimeIntervalToDate(hoursWithoutFormat)
        
    }
    
    class func isValidEmail(_ testStr:String) -> Bool {
        // print("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    class func validCanVarValue(_ string: String) -> Bool {
        
        if string.isEmpty == false && string != "-" {
            return true
        }
        
        return false
    }
    
    class func formatCanProtocol(canProtocol: String) -> String {
        var formattedName: String = ""
        
        if canProtocol == "-" {
            formattedName = "J1708/J1587"
        }else if canProtocol == "FMS / J1939" {
            formattedName = "J1939"
        }else if canProtocol == "OBD / ISO15765" {
            formattedName = "ISO 15765"
        }
        
        return formattedName
    }


    class func inviteKeyToString(key: String) -> String?{
        if let data = Data(base64Encoded: key, options: NSData.Base64DecodingOptions(rawValue: 0)) {
            let nsdataStr = NSData.init(data: data)
            return nsdataStr.description.trimmingCharacters(in: CharacterSet(charactersIn: "<>")).replacingOccurrences(of: " ", with: "")
        }
        
        return nil
    }

}

extension String {
    var length : Int {
        return self.count
    }
    
    func fromBase64() -> String? {
        guard let data = Data(base64Encoded: self, options: NSData.Base64DecodingOptions(rawValue: 0)) else {
            return nil
        }
        
        return String(data: data, encoding: String.Encoding.utf8)!
    }
    
    func toBase64() -> String? {
        guard let data = self.data(using: String.Encoding.utf8) else {
            return nil
        }
        
        return data.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
    }
    
    func keyToString() -> String?{
        if let data = Data(base64Encoded: self, options: NSData.Base64DecodingOptions(rawValue: 0)) {
            let nsdataStr = NSData.init(data: data)
            return nsdataStr.description.trimmingCharacters(in: CharacterSet(charactersIn: "<>")).replacingOccurrences(of: " ", with: "")
        }
        
        return nil
    }
    
    var isAlphanumericWithSpecialCharacters: Bool {
        let characterSet = CharacterSet(charactersIn: "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 /\\-_|")
        
        if (self.rangeOfCharacter(from: characterSet.inverted) != nil) {
            return false
        }
        
        return true
    }
    
    var isAlphanumericWithSpecialCharactersForTrailer: Bool {
        let characterSet = CharacterSet(charactersIn: "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789/\\-_|")
        
        if (self.rangeOfCharacter(from: characterSet.inverted) != nil) {
            return false
        }
        
        return true
    }

    
    func validAlphanumericCharacters() -> Bool! {
        let charset = CharacterSet.alphanumerics

        if self.rangeOfCharacter(from: charset) != nil {
            return true
        }
        
        return false
    }
    
    func getSubstringToIndex(_ index: Int) -> String {
        let subStr = self[self.index(self.startIndex, offsetBy: 0)...self.index(self.startIndex, offsetBy: index)]
        return String(subStr)
    }
    
    func isEmptyOrWhitespace() -> Bool {
        
        if(self.isEmpty) {
            return true
        }
        
        return (self.trimmingCharacters(in: CharacterSet.whitespaces) == "")
    }
    
    var isNumber : Bool {
        get{
            return !self.isEmpty && self.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
        }
    }
}

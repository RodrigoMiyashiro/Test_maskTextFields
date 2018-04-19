//  func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
//        
//        if self.userCPFField.text?.length > 13 && string.length != 0 && textField == self.userCPFField {
//            return false
//        }
//        
//        if textField == self.userCPFField {
//            
//            if string.length == 0 {
//                self.userCPFField.text = FormatText.formatCPFNumber(self.userCPFField.text!, backSpace: true);
//            }else{
//                self.userCPFField.text = FormatText.formatCPFNumber(self.userCPFField.text!, backSpace: false);
//            }
//        }
//        
//        return true
//    }

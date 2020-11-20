//
//  authentication.swift
//  TODOAPP_MVC_DEMO
//
//  Created by ahmedelbasha on 10/29/20.
//  Copyright © 2020 ahmedelbasha. All rights reserved.
//

import Foundation
extension String {
    var trimmed: String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
class validation{
               //MARK:- check validation of the password
    class func validpassword(mypassword : String) -> Bool
       {
           // MARK:- Minimum 8 and Maximum 10 characters at least 1 Uppercase Alphabet, 1 Lowercase Alphabet, 1 Number and 1 Special Character
           let passwordreg =  ("^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[$@$!%*?&#])[A-Za-z\\d$@$!%*?&#]{8,10}")
           let passwordtesting = NSPredicate(format: "SELF MATCHES %@", passwordreg)
           return passwordtesting.evaluate(with: mypassword)
       }
               //MARK:- check validation of the email
       class func isValidEmail(candidate: String) -> Bool {
           
           let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
           var valid = NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: candidate)
           if valid {
               valid = !candidate.contains("..")
           }
           return valid
       }
            //MARK:- check validation of the phone
       class func isValidPhone(phone: String) -> Bool {
           let phoneRegex = "^[0-9]{6,14}$";
           let valid = NSPredicate(format: "SELF MATCHES %@", phoneRegex).evaluate(with: phone)
           return valid
       }
        //MARK:- check if the textField is empty
       class func fieldIsNotEmpty(field: String?) -> Bool{
        guard let field = field?.trimmed, !field.isEmpty else {
                     return false
                 }
           return true
       }

}


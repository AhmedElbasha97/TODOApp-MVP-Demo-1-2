//
//  SignUpVCPresenter.swift
//  TODOApp-MVC-Demo
//
//  Created by ahmedelbash on 11/13/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import Foundation
class SignUpVCPresenter{
    //MARK:- delegate
       var delegate : authenticationPresenterDelegate!
    //MARK:- sign up
    func SignningUP(name: String, email: String, password: String, age: String, completion: @escaping () -> Void)  {
        if CheckFieldsIsNotEmpty(name: name, Password: password, Email: email, Age: age){
            if checkValidation(Password: password, Email: email){
              SignUP(name:name , Password: password, Email: email , Age: age){
                  completion()
                      }
                  }
              }
    }
}
//MARK:- APIS extension
extension SignUpVCPresenter{
    // MARK:- API
    private func SignUP(name: String, Password:String, Email:String, Age:String, completion: @escaping () -> Void ) {
        
        APIManager.Registier(name: name, email: Email, Age: Age, password: Password) { (response) in
            switch response{
            case .failure(let error):
                self.delegate.PresentError(errorMassage: "\(error.localizedDescription)")
             
            case .success(let result):
                UserDefaultsManager.shared().token = result.token
                              completion()
                
            }
        }
    
    }
}
//MARK:- Validatons
extension SignUpVCPresenter{
     //MARK:- Fields Isn't Empty
    private func CheckFieldsIsNotEmpty(name: String, Password:String, Email:String, Age:String) -> Bool{
     if fieldIsNotEmpty(field: name){
        if fieldIsNotEmpty(field: Email){
          if fieldIsNotEmpty(field: Password){
             if fieldIsNotEmpty(field: Age){
                 return true
             }else{
                self.delegate.PresentError(errorMassage: "please write your age")
     
             }
          }else{
            self.delegate.PresentError(errorMassage: "please write your password")
        
          }
         }else{
             self.delegate.PresentError(errorMassage: "please write your E-Mail")
            
         }
     }else{
          self.delegate.PresentError(errorMassage: "please write your Name")
       
     }
     return false
     }
     // MARK:- check validation
     private func checkValidation(Password:String, Email:String) -> Bool{
         if isValidEmail(candidate: Email){
             if validpassword(mypassword: Password){
                 
                 return true
             }else{
                self.delegate.PresentError(errorMassage: "The Password Must Be Minimum 8 and Maximum 10 characters at least 1 Uppercase Alphabet, 1 Lowercase Alphabet, 1 Number and 1 Special Character")
           
             }
         }else{
            self.delegate.PresentError(errorMassage: "please put your valid E-Mail")
            
         }
         return false
     }
}

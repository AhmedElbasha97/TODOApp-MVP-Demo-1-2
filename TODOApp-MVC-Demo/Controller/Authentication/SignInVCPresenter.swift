//
//  SignInPresenterVC.swift
//  TODOApp-MVC-Demo
//
//  Created by ahmedelbash on 11/11/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//
protocol authenticationPresenterDelegate {
    func PresentError(errorMassage: String)
}

import Foundation


class SignInVCPresenter{
    //MARK:- delegate
    var delegate : authenticationPresenterDelegate!
    //MARK:- signInMethod
    func signingInMethod(email: String, Password: String, completion: @escaping () -> Void){
        if self.CheckFieldsIsNotEmpty(email: email, password: Password){
            if self.checkValidation(email: email, password: Password){
                self.loggingIn(email: email, Password: Password){
                    completion()
                }
            }
        }
           
        }
  
    }
    

extension SignInVCPresenter{
     // MARK:- Private Func
     // MARK:- API
    private func loggingIn(email: String, Password: String, completion: @escaping () -> Void){
        
        APIManager.LogIn(email: email, password: Password) { (response) in
            switch (response){
            case .failure(let error):
                 self.delegate.PresentError(errorMassage: error.localizedDescription)
                break
            case .success(let result):
                UserDefaultsManager.shared().token = result.token
                completion()
            }
        }
       
    }
}
//MARK:- Validatons
extension SignInVCPresenter{
    //MARK:- Fields Isn't Empty
    private func CheckFieldsIsNotEmpty(email: String, password: String) -> Bool {
        if fieldIsNotEmpty(field: email){
          if fieldIsNotEmpty(field: password){
              return true
          }else{
            self.delegate.PresentError(errorMassage: "please write your password")
          return false
            }
         }else{
            self.delegate.PresentError(errorMassage: "please write your email")
            return false
         }
     }
    // MARK:- check validation
    private func checkValidation(email: String, password: String) -> Bool{
        if isValidEmail(candidate:email){
            if validpassword(mypassword: password){
                 return true
                
            }else{
                self.delegate.PresentError(errorMassage: "The Password Must Be Minimum 8 and Maximum 10 characters at least 1 Uppercase Alphabet, 1 Lowercase Alphabet, 1 Number and 1 Special Character")
                return false
            }
        }else{
         self.delegate.PresentError(errorMassage: "Enter Valid E-Mail")
        return false
        }
       
    }
}

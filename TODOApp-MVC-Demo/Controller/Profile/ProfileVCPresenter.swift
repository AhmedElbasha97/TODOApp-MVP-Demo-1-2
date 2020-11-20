//
//  ProfileVCPresenter.swift
//  TODOApp-MVC-Demo
//
//  Created by ahmedelbash on 11/13/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

protocol  ProfileVCPresenterDelegate{
func showloader()
func hideLoader()
func PresentError(errorMassage: String)
func setUpUserData(name: String, email: String, age: Int, id: String)
func setUpUserImage(userImage: Data)
func setDefaultUserimage()
func GoToSignInVC()
}

import Foundation

class ProfileVCPresenter{
    //MARK:- delegate
      var delegate: ProfileVCPresenterDelegate!
    //MARK:- get user image from VC
    func getUserImageFromVC(image: Data, id: String){
        self.sendUserImage(image: image, id: id)
    }
    //MARK:- get all user data
    func getUserData(){
        self.getDataOfTheUser()
    }
    //MARK:- UpdateUserData
    func UpdateUserDate(name: String = "", age: String = "", email:String = ""){
        if self.checkVedlition(name: name, age: age, email: email){
             self.editUserProfile(name: name, age: age, email: email)
        }
    }
    //MARK:- logOutTheUser
    func LoggingOut(){
        self.LogOut()
         UserDefaultsManager.shared().token = nil
    }
}

extension ProfileVCPresenter{
    //MARK:- privateFunc
    //MARK:- APIs
    //MARK:- get user data
       private func getDataOfTheUser() {
        self.delegate.showloader()
           APIManager.getUserData { (response) in
               switch response{
               case .failure(let error):
                   print("\(error.localizedDescription)")
                 self.delegate.PresentError(errorMassage: "\(error.localizedDescription)")
               case .success(let UserData):
                self.delegate.setUpUserData(name: UserData.name, email: UserData.email, age: UserData.age, id: UserData.id)
                          self.GetUserImage(id: UserData.id)
               }
        }
        self.delegate.hideLoader()
    }
    //MARK:- send user image
    private func sendUserImage(image: Data, id:String){
       
        APIManager.uploadImage(userimage: image ) { (result) in
            if result{
                self.GetUserImage(id: id)
            }else{
                self.delegate.PresentError(errorMassage: "your image will not be uploaded please try again later")
              
            }
        }
    }
     //MARK:- log out user
    private func LogOut() {
     APIManager.logOutTheUser { (response) in
         switch response{
         case .failure(let error):
             print("\(error.localizedDescription)")
            self.delegate.PresentError(errorMassage: "\(error.localizedDescription)")
         case .success(_ ):
            self.delegate.GoToSignInVC()
         }
     }
    }
        //MARK:- get User Image
        func GetUserImage(id: String){
            APIManager.getUserImage(with: id) { (response) in
                switch response{
                case.failure(let error):
                    print("\(error.localizedDescription)")
                   self.delegate.PresentError(errorMassage: "\(error.localizedDescription)")
                    self.delegate.setDefaultUserimage()
                case.success(let data):
                    self.delegate.setUpUserImage(userImage: data)
                }
            }
        }
    //MARK:- edit user profile
    private func editUserProfile(name: String = "", age: String = "", email:String = ""){
        self.delegate.showloader()
        APIManager.updteDataOfTheUser(name: name, email: email, Age: age) { (response) in
              switch response{
              case .failure(let error):
                  print("\(error.localizedDescription)")
                  self.delegate.PresentError(errorMassage: "\(error.localizedDescription)")
                case .success(let UserData):
                    self.delegate.setUpUserData(name: UserData.userData.name, email: UserData.userData.email, age: UserData.userData.age, id: UserData.userData.id)
                  
              }
          }
        self.delegate.hideLoader()
      }
}
//MARK:- validation
extension ProfileVCPresenter{
    //MARK:- check validation
    private func checkVedlition(name: String = "", age: String = "", email:String = "") -> Bool {
        if validation.fieldIsNotEmpty(field: name){
            return true
        }else if validation.fieldIsNotEmpty(field: email){
            if validation.isValidEmail(candidate: email){
             return true
            }else{
                self.delegate.PresentError(errorMassage: "please enter valid email")
                }
            }else if validation.fieldIsNotEmpty(field: age){
        return true
        }else{
            self.delegate.PresentError(errorMassage: "please enter anything to edit your profile.")
           
        }
    
    return false
        
    }
}

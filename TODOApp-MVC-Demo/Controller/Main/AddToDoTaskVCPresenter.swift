//
//  AddToDoTaskVCPresenter.swift
//  TODOApp-MVC-Demo
//
//  Created by ahmedelbash on 11/15/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//
protocol AddToDoTaskVCPresenterDelegate {
    func PresentError(errorMassage: String)
    func Dismiss()    
}
import Foundation
class AddToDoTaskVCPresenter{
    //MARK:- delegate
    var delegate: AddToDoTaskVCPresenterDelegate!
    //MARK:- PUBLIC FUNC
    func senddata(task: String, completion: @escaping () -> Void){
        if fieldIsNotEmpty(field:task){
           SendTaskData(task: task)
            completion()
            self.delegate.Dismiss()
          
        }else{
            self.delegate.PresentError(errorMassage: "please input your task")
        
    }
}
}
//MARK:- APIS
extension AddToDoTaskVCPresenter{
     //MARK:- APIS
    //MARK:- send task data
    private func SendTaskData(task: String){
     APIManager.addTask(task: task) { (response) in
         switch response{
         case .failure(let error):
             print("\(error.localizedDescription)")
 self.delegate.PresentError(errorMassage: "\(error.localizedDescription)")
         case .success( _): break
            
         }
     }
        }
}


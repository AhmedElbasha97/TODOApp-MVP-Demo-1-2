//
//  todoListVCPrsenter.swift
//  TODOApp-MVC-Demo
//
//  Created by ahmedelbash on 11/15/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//
protocol TodoListVCPrsenterDelegate {
    func showloader()
    func hideLoader()
    func PresentError(errorMassage: String)
    func setUpToDoTable(taskList: [String], idList: [String])
    func GoToProfile()
    func AddToDo()
    func reloadData()
}
import Foundation
class TodoListVCPrsenter{
    // MARK:- delegate
var delegate: TodoListVCPrsenterDelegate!
    //MARK:- public func
    func getTadaForTodoTable(){
        getData()
    }
    func deleteTask(taskID: String){
        DeleteTask(taskId: taskID) {
            self.getData()
        }
    }
}
 //MARK:- APIS
extension TodoListVCPrsenter{
     //MARK:- getDataOfTodoTable
 private func getData(){
    self.delegate.showloader()
     APIManager.getTodos { (response) in
         switch response{
         case .failure(let error):
             print("\(error.localizedDescription)")
             self.delegate.PresentError(errorMassage: "\(error.localizedDescription)")
         case.success(let result):
              var tasks: [String] = []
                   var tasksId: [String] = []
                   for todo in result.data{
                   tasks.append(todo.description)
                    tasksId.append(todo.id)
                   }
              self.delegate.setUpToDoTable(taskList: tasks, idList: tasksId)
              self.delegate.reloadData()
            
         }
     }
     self.delegate.hideLoader()
     
   }
//MARK:- deleteTAsk
    private func DeleteTask(taskId: String, completion: @escaping () -> Void ){
        APIManager.DelteTaskByid(taaskId: taskId) { (result) in
        switch result{
        case .failure(let error):
            print("\(error.localizedDescription)")
                 self.delegate.PresentError(errorMassage: "\(error.localizedDescription)")
        case .success(_ ):
             completion()
        }
    }
       
}

}

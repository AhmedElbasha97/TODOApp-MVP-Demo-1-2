//
//  AddTaskVC.swift
//  TODOApp-MVC-Demo
//
//  Created by ahmedelbash on 10/31/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import UIKit
protocol refreshDataDelegate: AnyObject {
    func refreshData()
}
class AddTaskVC: UIViewController {
   //MARK:- Outlets
    @IBOutlet weak var addTask: UITextField!
    @IBOutlet weak var addTaskBTN: UIButton!
    @IBOutlet weak var addTaskView: UIView!
    //MARK:- variables 
   weak var delegate: refreshDataDelegate?
    var presenter: AddToDoTaskVCPresenter!
    // MARK:- Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        SetUpDelegateAndPresenter()
        setUpSubViews()
    }
//MARK:- Buttons
    //MARK:- Exit Buuton
    @IBAction func exitBTN(_ sender: Any) {
     Dismiss()
    }
    //MARK:- Add Task Button
    @IBAction func AddTaskBtn(_ sender: Any) {
        presenter.senddata(task: addTask.text ?? "") {
            self.delegate?.refreshData()
        }
    }
    //Mark:- puplic Method
    class func create() -> AddTaskVC {
        let addToDoVC: AddTaskVC = UIViewController.create(storyboardName: Storyboards.main, identifier: ViewControllers.addToDoVC)
        return addToDoVC
    }
}
extension AddTaskVC{
   //MARK:- private Methods
  //MARK:- sup views
    private func setUpSubViews(){
        shapeOfTextField(textView: addTask)
           self.navigationController?.isNavigationBarHidden = false
          shapeTheBTN(BTN: addTaskBTN)
          addTaskView.layer.cornerRadius = 25
          self.addTaskView.backgroundColor = UIColor(patternImage: UIImage(named: "\(Background.athentication)")! )
    }
    //MARK:- setupPresenter&delegate
      private func SetUpDelegateAndPresenter(){
          presenter = AddToDoTaskVCPresenter()
          presenter.delegate = self
      }
}
extension AddTaskVC: AddToDoTaskVCPresenterDelegate{
    func PresentError(errorMassage: String) {
        self.showAlert(title: "sorry", massage: "\(errorMassage)")
    }
    
    func Dismiss() {
          self.dismiss(animated: true, completion: nil)
    }
}


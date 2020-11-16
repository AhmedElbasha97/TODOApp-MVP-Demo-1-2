//
//  ViewController.swift
//  TODOApp-MVC-Demo
//
//  Created by ahmedelbash on 10/27/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import UIKit

class TodoListVC: UIViewController {
//MARK:- variables
   private var arrOfTask: [String] = []
   private var arrOfTaskId: [String] = []
    var presenter: TodoListVCPrsenter!
//MARK:- Outlets
    @IBOutlet weak var todoTable: UITableView!
    // MARK:- Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
          SetUpDelegateAndPresenter()
          setUpNavBar()
          setupTableView()
          presenter.getTadaForTodoTable()
    }
    //MARK:- Buttons
    //MARK:- GO TO profile button
    @IBAction func profileBTN(_ sender: Any) {
          GoToProfile()
    }
    //MARK:- ADD task button
    @IBAction func addTaskBTN(_ sender: UIBarButtonItem) {
     AddToDo()
    }
    // MARK:- Public Methods
    class func create() -> TodoListVC {
        let todoListVC: TodoListVC = UIViewController.create(storyboardName: Storyboards.main, identifier: ViewControllers.todoListVC)
        return todoListVC
    }
}
//MARK:- TableView Delegate
extension TodoListVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
          return 125.0
      }
      
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrOfTask.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Cells.todoCell, for: indexPath) as? TodoCell else {
               return UITableViewCell()
           }
        cell.configure(todo: arrOfTask[indexPath.row], idOfToDo: arrOfTaskId[indexPath.row])
        cell.delegate = self
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.todoTable.deselectRow(at: indexPath, animated: true)
    }
    
    
}
extension TodoListVC{
 
    //MARK:- Subviews
    //MARK:- Set up nav bar
    func setUpNavBar(){
    navigationItem.title = "Todo List"
    self.navigationController?.isNavigationBarHidden = false
    }
    
    //MARK- set up todo table
    private func setupTableView() {
        self.todoTable.register(UINib.init(nibName: Cells.todoCell, bundle: nil), forCellReuseIdentifier: Cells.todoCell)
        self.todoTable.dataSource = self
        self.todoTable.delegate = self
        self.todoTable.separatorStyle = UITableViewCell.SeparatorStyle.none
        self.todoTable.backgroundView = UIImageView(image: UIImage(named: "\(Background.insideTheApp)"))
    
    }
    //MARK:- setupPresenter&delegate
      private func SetUpDelegateAndPresenter(){
          presenter = TodoListVCPrsenter()
          presenter.delegate = self
      }
}
//MARK:- showAlertDelegate
extension TodoListVC: showAlertOfDeletingDelegate{
    func showAlertOfDeleting(customTableViewCell: UITableViewCell, didTapButton button: UIButton, taskId: String) {
     print("protocol of vc")
             let alert = UIAlertController(title: "Sorry", message: "Are You Sure Want to Delete this TODO?", preferredStyle: .alert)
             
             let noAction = UIAlertAction(title: "No", style: .cancel) { (action) in
                 alert.dismiss(animated: true, completion: nil)
             }
             
             let yesAction = UIAlertAction(title: "Yes", style: .destructive) { (action) in
                self.presenter.deleteTask(taskID: taskId)
                
             }
             alert.addAction(noAction)
             alert.addAction(yesAction)
             self.present(alert, animated: true, completion: nil)
         }
    }
    //MARK: refreshDatadelegate
extension TodoListVC: refreshDataDelegate{
    func refreshData() {
        presenter.getTadaForTodoTable()
    }
}
extension TodoListVC: TodoListVCPrsenterDelegate{
    func showloader() {
        self.view.showLoader()
    }
    
    func hideLoader() {
        self.view.hideLoader()
    }
    
    func PresentError(errorMassage: String) {
         self.showAlert(title: "sorry", massage: "\(errorMassage)")
    }
    
    func setUpToDoTable(taskList: [String], idList: [String]) {
        self.arrOfTask = taskList
        self.arrOfTaskId = idList
    }
    
    func GoToProfile() {
             self.navigationController!.pushViewController(ProfileVC.create(), animated: true)
    }
    
    func AddToDo() {
        let addTaskVC = AddTaskVC.create()
        addTaskVC.delegate = self
        present(addTaskVC, animated: true)

    }
    
    func reloadData() {
        self.todoTable.reloadData()
       
    }
    
    
}

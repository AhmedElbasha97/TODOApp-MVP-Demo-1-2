//
//  SignInVC.swift
//  TODOApp-MVC-Demo
//
//  Created by ahmedelbash on 10/27/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import UIKit

class SignInVC: UIViewController {
    //MARK:- Outlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var sigininBtnOutlet: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
       
    var  presenter: SignInVCPresenter!
    
    // MARK:- Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        SetUpDelegateAndPresenter()
        setUpSupViews()
        setUpNavBar()
     
    }
    //MARK:- buttons
    //MARK:- gotoSignUpVC
    @IBAction func signUpBTN(_ sender: Any) {
        self.navigationController!.pushViewController(SignUPVC.create(), animated: true)
    }
    //MARK:- signIn Button
    @IBAction func signInBTN(_ sender: Any) {
        presenter.signingInMethod(email: emailTextField.text ?? "", Password: passwordTextField.text ?? "") {
            self.GoToToDovc()
        }
    }
    // MARK:- Public Methods
    class func create() -> SignInVC {
        let signInVC: SignInVC = UIViewController.create(storyboardName: Storyboards.authentication, identifier: ViewControllers.signInVC)
        return signInVC
    }

}
extension SignInVC{
    //MARK:- setupPresenter&delegate
    private func SetUpDelegateAndPresenter(){
        presenter = SignInVCPresenter()
        presenter.delegate = self
    }
     //MARK:- supViews as textFields & Buttons
     private func setUpSupViews(){
         setUpTheBackGroundImage(imageName: "\(Background.athentication)")
              shapeTheBTN(BTN: sigininBtnOutlet)
             shapeOfTextField(textView: emailTextField)
              addIconToTextView(iconName: "emailIcon", textField: emailTextField)
              shapeOfTextField(textView: passwordTextField)
              addIconToTextView(iconName: "passwordIcon", textField: passwordTextField)
          
         
     }
     //MARK:- Navigation Bar
     private func setUpNavBar(){
           self.navigationController?.isNavigationBarHidden = true
               
     }

     // MARK:- go todo list vc
     private func GoToToDovc(){
               let todoListVC = TodoListVC.create()
        let navigationController = UINavigationController(rootViewController: todoListVC)
        AppDelegate.shared().window?.rootViewController = navigationController
     }
}
//MARK:- ShowAlertForError
extension SignInVC: authenticationPresenterDelegate{
    func PresentError(errorMassage: String) {
          showAlert(title: "sorry", massage: "\(errorMassage)")
    }
}

//
//  SignUpVC.swift
//  TODOApp-MVC-Demo
//
//  Created by ahmedelbash on 10/27/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//
import UIKit

class SignUPVC: UIViewController {
    //MARK:- Outlets
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var siginupBtnOutlet: UIButton!
    @IBOutlet weak var ageTextField: UITextField!
    //MARK:- delegate
    var  presenter: SignUpVCPresenter!
    // MARK:- Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
     setUpSupViews()
      setUpNavBar()
      SetUpDelegateAndPresenter()
        
    }
   //MARK:- buttons
   //MARK:- goToSignInScreen
    @IBAction func goToSignInBTN(_ sender: Any) {
         self.navigationController!.pushViewController(SignInVC.create(), animated: true)
        
    }
    //MARK:- signUp
    @IBAction func signUpBTN(_ sender: Any) {
        presenter.SignningUP(name: nameTextField.text ?? "", email: emailTextField.text ?? "", password: passwordTextField.text ?? "", age: ageTextField.text ?? "") {
            self.GoToToDovc()
        }
    }
    // MARK:- Public Methods
    class func create() -> SignUPVC {
        let signUpVC: SignUPVC = UIViewController.create(storyboardName: Storyboards.authentication, identifier: ViewControllers.signUpVC)
        return signUpVC
    }

}
extension SignUPVC{
    //MARK:- supViews as textFields & Buttons
    private func setUpSupViews(){
        setUpTheBackGroundImage(imageName: "\(Background.athentication)")
             shapeTheBTN(BTN: siginupBtnOutlet)
             shapeOfTextField(textView: nameTextField)
             addIconToTextView(iconName: "userNameIcon", textField: nameTextField)
             shapeOfTextField(textView: emailTextField)
             addIconToTextView(iconName: "emailIcon", textField: emailTextField)
             shapeOfTextField(textView: passwordTextField)
             addIconToTextView(iconName: "passwordIcon", textField: passwordTextField)
             shapeOfTextField(textView: ageTextField)
             addIconToTextView(iconName: "userAge", textField: ageTextField)
        
    }
    //MARK:- Navigation Bar
    private func setUpNavBar(){
          self.navigationController?.isNavigationBarHidden = true
              
    }
    
    private func SetUpDelegateAndPresenter(){
        presenter = SignUpVCPresenter()
        presenter.delegate = self
    }

    // MARK:- go todo list vc
    private func GoToToDovc(){
       let todoListVC = TodoListVC.create()
       let navigationController = UINavigationController(rootViewController: todoListVC)
       AppDelegate.shared().window?.rootViewController = navigationController
    }
}
//MARK:- SHOW ERROR
extension SignUPVC: authenticationPresenterDelegate{
    func PresentError(errorMassage: String) {
        self.showAlert(title: "sorry", massage: "\(errorMassage)")
    }
    
    
}

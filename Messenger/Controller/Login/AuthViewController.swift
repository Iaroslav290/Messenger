//
//  RegisterViewController.swift
//  Messenger
//
//  Created by Ярослав Вербило on 2023-06-21.
//

import UIKit

class AuthViewController: UIViewController {

    let nameLabel = UILabel()
    let logInLabel = UILabel()
    let logInButton = UIButton()
    let dontHaveAccButton = UIButton()
    let forgotPassButton = UIButton()
    let closeButton = UIButton()
    let loginTextField = UITextField()
    let passTextField = UITextField()
    let loginView = UIView()
    let passwordView = UIView()
    var userDefault = UserDefaults.standard

    
   
    
    var delegate: LoginViewControllerDelegate!
    var service = Service.shared
    var checkField = CheckField.shared

    
    var tapGest: UITapGestureRecognizer!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setSignUp()
        
        tapGest = UITapGestureRecognizer(target: self, action: #selector(endEgiting))
        view.addGestureRecognizer(tapGest)
    }
    

    
    func setSignUp() {
        [loginView, passwordView, nameLabel, logInLabel, logInButton, dontHaveAccButton, forgotPassButton, closeButton, passTextField, loginTextField].forEach{
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        view.backgroundColor = UIColor(red: 47/255, green: 53/255, blue: 66/255, alpha: 1)
        
        nameLabel.text = "Regular Chat"
        nameLabel.textColor = .white
//        nameLabel.font = UIFont.boldSystemFont(ofSize: 34)
        nameLabel.font = UIFont.systemFont(ofSize: 34, weight: .bold)
        
        logInLabel.text = "Log In"
        logInLabel.textColor = .white
        logInLabel.font = UIFont.systemFont(ofSize: 28, weight: .semibold)
        
        let attributesSignUp: [NSAttributedString.Key: Any] = [
                    .font: UIFont.systemFont(ofSize: 32, weight: .bold)
                ]
        let attributedTitleSignUp = NSAttributedString(string: "Log In", attributes: attributesSignUp)
        logInButton.setAttributedTitle(attributedTitleSignUp, for: .normal)
        logInButton.backgroundColor = UIColor(red: 83/255, green: 82/255, blue: 237/255, alpha: 1)
        logInButton.layer.cornerRadius = 59/2
        logInButton.setTitleColor(.white, for: .normal)
        logInButton.addTarget(self, action: #selector(loginAction), for: .touchUpInside)
        
        
        let attributesHaveAcc: [NSAttributedString.Key: Any] = [
                    .font: UIFont.systemFont(ofSize: 24, weight: .light)
                ]
        let attributedTitleHaveAcc = NSAttributedString(string: "Don't have an account?", attributes: attributesHaveAcc)
        dontHaveAccButton.setAttributedTitle(attributedTitleHaveAcc, for: .normal)
        dontHaveAccButton.setTitleColor(.white, for: .normal)
        
        closeButton.setImage(UIImage(named: "close"), for: .normal)
        closeButton.tintColor = .white
        closeButton.addTarget(self, action: #selector(closeAction), for: .touchUpInside)

        
        let attributesForgotPass: [NSAttributedString.Key: Any] = [
                    .font: UIFont.systemFont(ofSize: 20, weight: .light)
                ]
        let attributedTitleForgotPass = NSAttributedString(string: "Forgot password?", attributes: attributesForgotPass)
        forgotPassButton.setAttributedTitle(attributedTitleForgotPass, for: .normal)
        forgotPassButton.setTitleColor(.white, for: .normal)
        
        //loginTextField.borderStyle = .roundedRect
        //loginTextField.layer.cornerRadius = 20
        //loginTextField.layer.borderWidth = 5
        //loginTextField.layer.borderColor = UIColor.black.cgColor
    //    loginTextField.backgroundColor = UIColor.init(red: 50/255, green: 50/255, blue: 50/255, alpha: 1)
        loginTextField.backgroundColor = .clear
        loginTextField.textColor = .black
        loginTextField.attributedPlaceholder = NSAttributedString(string: "Login", attributes: [NSAttributedString.Key.foregroundColor: UIColor.init(red: 130/255, green: 130/255, blue: 130/255, alpha: 1)])
        loginTextField.restorationIdentifier = "email"

        
//        passwordTextField.borderStyle = .roundedRect
//        passwordTextField.layer.cornerRadius = 10
//        passwordTextField.layer.borderWidth = 5
//        passwordTextField.layer.borderColor = UIColor.black.cgColor
    //    passwordTextField.backgroundColor = UIColor.init(red: 50/255, green: 50/255, blue: 50/255, alpha: 1)
//        passworddTextField.backgroundColor = .clear
//        passworddTextField.textColor = .black
//        passworddTextField.attributedPlaceholder = NSAttributedString(string: "Enter Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.init(red: 130/255, green: 130/255, blue: 130/255, alpha: 1)])
//        passworddTextField.isSecureTextEntry = true
        
        passTextField.backgroundColor = .clear
        passTextField.textColor = .black
        passTextField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.init(red: 130/255, green: 130/255, blue: 130/255, alpha: 1)])
        passTextField.isSecureTextEntry = true
        passTextField.textContentType = .oneTimeCode
        passTextField.restorationIdentifier = "password"


        
       
        
        loginView.backgroundColor = .white
        loginView.layer.cornerRadius = 59/2
        
        passwordView.backgroundColor = .white
        passwordView.layer.cornerRadius = 59/2
        
       
        
        NSLayoutConstraint.activate([
            
            
            nameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 126),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 48),
            
            logInLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 70),
            logInLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            logInButton.topAnchor.constraint(equalTo: dontHaveAccButton.bottomAnchor, constant: 20),
            logInButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 57),
            logInButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -57),
            logInButton.heightAnchor.constraint(equalToConstant: 59),
            
            forgotPassButton.topAnchor.constraint(equalTo: passTextField.bottomAnchor, constant: 20),
            forgotPassButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 48),
            forgotPassButton.heightAnchor.constraint(equalToConstant: 24),
            
            loginTextField.topAnchor.constraint(equalTo: logInLabel.bottomAnchor, constant: 20),
            loginTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 47),
            loginTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -47),
            loginTextField.heightAnchor.constraint(equalToConstant: 59),
            
            
            
            loginView.topAnchor.constraint(equalTo: loginTextField.topAnchor, constant: -5),
            loginView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            loginView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            loginView.bottomAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 5),
            
            passTextField.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 20),
            passTextField.leadingAnchor.constraint(equalTo: loginTextField.leadingAnchor),
            passTextField.trailingAnchor.constraint(equalTo: loginTextField.trailingAnchor),
            passTextField.heightAnchor.constraint(equalToConstant: 59),
            
            passwordView.topAnchor.constraint(equalTo: passTextField.topAnchor, constant: -5),
            passwordView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            passwordView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            passwordView.bottomAnchor.constraint(equalTo: passTextField.bottomAnchor, constant: 5),
            
            dontHaveAccButton.topAnchor.constraint(equalTo: forgotPassButton.bottomAnchor, constant: 20),
            dontHaveAccButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dontHaveAccButton.heightAnchor.constraint(equalToConstant: 29),
            
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            closeButton.widthAnchor.constraint(equalToConstant: 25),
            closeButton.heightAnchor.constraint(equalToConstant: 25),
            
//
            
        ])
        
        
    }
    
    @objc func endEgiting() {
        self.view.endEditing(true)
    }
    
    @objc func closeAction() {
        delegate.closeVc()
    }
    
    @objc func loginAction() {
        if checkField.validField(loginView, loginTextField),
           checkField.validField(passwordView, passTextField) {
            
            let authData = LoginField(email: loginTextField.text!, password: passTextField.text!)
            
            service.authInApp(authData) { [weak self] responce in
                switch responce {
                case .success:
                    self?.userDefault.set(true, forKey: "isLogin")
                    self?.delegate.startApp()
                    self?.delegate.closeVc()
//                    closeBar.isHidden = true
                case .noVerify:
                    let alert = self?.alertAction("Error", "You didn't verify your email. On your email was sended a link")
                    let verifyButton = UIAlertAction(title: "OK", style: .cancel)
                    alert?.addAction(verifyButton)
                    self?.present(alert!, animated: true)
                case .error:
                    let alert = self?.alertAction("Error", "Email or Password wrong")
                    let verifyButton = UIAlertAction(title: "OK", style: .cancel)
                    alert?.addAction(verifyButton)
                    self?.present(alert!, animated: true)
                }
            }
            
        } else {
            let alert = self.alertAction("Error", "Check info which you write")
            let verifyButton = UIAlertAction(title: "OK", style: .cancel)
            alert.addAction(verifyButton)
            self.present(alert, animated: true)
        }
    }
    
    func alertAction(_ header: String?, _ message: String?) -> UIAlertController {
        let alert = UIAlertController(title: header, message: message, preferredStyle: .alert)
        return alert
    }
   
}

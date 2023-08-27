//
//  AuthViewController.swift
//  Messenger
//
//  Created by Ярослав Вербило on 2023-06-21.
//

import UIKit

class RViewController: UIViewController {

    let nameLabel = UILabel()
    let signUpLabel = UILabel()
    let signUpButton = UIButton()
    let haveAccButton = UIButton()
    let closeButton = UIButton()
    let loginTextField = UITextField()
    let passTextField = UITextField()
    let repeatPassTextField = UITextField()
    let loginView = UIView()
    let passwordView = UIView()
    let repeatPasswordView = UIView()
    
    var tapGest: UITapGestureRecognizer!
    
    var service = Service.shared
    
    var delegate: LoginViewControllerDelegate!
    var checkField = CheckField.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setSignUp()
        
        tapGest = UITapGestureRecognizer(target: self, action: #selector(endEgiting))
        view.addGestureRecognizer(tapGest)
        
    }
    
    func setSignUp() {
        [loginView, passwordView, repeatPasswordView, nameLabel, signUpLabel, signUpButton, haveAccButton, closeButton, passTextField, loginTextField, repeatPassTextField].forEach{
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        view.backgroundColor = UIColor(red: 47/255, green: 53/255, blue: 66/255, alpha: 1)
        
        nameLabel.text = "Regular Chat"
        nameLabel.textColor = .white
//        nameLabel.font = UIFont.boldSystemFont(ofSize: 34)
        nameLabel.font = UIFont.systemFont(ofSize: 34, weight: .bold)
        
        signUpLabel.text = "Sign Up"
        signUpLabel.textColor = .white
        signUpLabel.font = UIFont.systemFont(ofSize: 28, weight: .semibold)
        
        let attributesSignUp: [NSAttributedString.Key: Any] = [
                    .font: UIFont.systemFont(ofSize: 32, weight: .bold)
                ]
        let attributedTitleSignUp = NSAttributedString(string: "Sign Up", attributes: attributesSignUp)
        signUpButton.setAttributedTitle(attributedTitleSignUp, for: .normal)
        signUpButton.backgroundColor = UIColor(red: 83/255, green: 82/255, blue: 237/255, alpha: 1)
        signUpButton.layer.cornerRadius = 59/2
        signUpButton.setTitleColor(.white, for: .normal)
        signUpButton.addTarget(self, action: #selector(signUpAction), for: .touchUpInside)
        
        let attributesHaveAcc: [NSAttributedString.Key: Any] = [
                    .font: UIFont.systemFont(ofSize: 24, weight: .light)
                ]
        let attributedTitleHaveAcc = NSAttributedString(string: "Do you have an account?", attributes: attributesHaveAcc)
        haveAccButton.setAttributedTitle(attributedTitleHaveAcc, for: .normal)
        haveAccButton.setTitleColor(.white, for: .normal)
        
        closeButton.setImage(UIImage(named: "close"), for: .normal)
        closeButton.tintColor = .white
        closeButton.addTarget(self, action: #selector(closeAction), for: .touchUpInside)
        
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

        
        repeatPassTextField.backgroundColor = .clear
        repeatPassTextField.textColor = .black
        repeatPassTextField.attributedPlaceholder = NSAttributedString(string: "Repeat Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.init(red: 130/255, green: 130/255, blue: 130/255, alpha: 1)])
        repeatPassTextField.isSecureTextEntry = true
        repeatPasswordView.restorationIdentifier = "repeat password"
        
        loginView.backgroundColor = .white
        loginView.layer.cornerRadius = 59/2
        
        passwordView.backgroundColor = .white
        passwordView.layer.cornerRadius = 59/2
        
        repeatPasswordView.backgroundColor = .white
        repeatPasswordView.layer.cornerRadius = 59/2
        
        NSLayoutConstraint.activate([
            
            
            nameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 126),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 48),
            
            signUpLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 70),
            signUpLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            signUpButton.topAnchor.constraint(equalTo: haveAccButton.bottomAnchor, constant: 20),
            signUpButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 57),
            signUpButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -57),
            signUpButton.heightAnchor.constraint(equalToConstant: 59),
            
            loginTextField.topAnchor.constraint(equalTo: signUpLabel.bottomAnchor, constant: 20),
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
            
            passwordView.topAnchor.constraint(equalTo: passTextField.topAnchor,  constant: -5),
            passwordView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            passwordView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            passwordView.bottomAnchor.constraint(equalTo: passTextField.bottomAnchor,  constant: 5),
            
            repeatPassTextField.topAnchor.constraint(equalTo: passTextField.bottomAnchor, constant: 20),
            repeatPassTextField.leadingAnchor.constraint(equalTo: loginTextField.leadingAnchor),
            repeatPassTextField.trailingAnchor.constraint(equalTo: loginTextField.trailingAnchor),
            repeatPassTextField.heightAnchor.constraint(equalToConstant: 59),
            
            repeatPasswordView.topAnchor.constraint(equalTo: repeatPassTextField.topAnchor,  constant: -5),
            repeatPasswordView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            repeatPasswordView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            repeatPasswordView.bottomAnchor.constraint(equalTo: repeatPassTextField.bottomAnchor,  constant: 5),
            
            haveAccButton.topAnchor.constraint(equalTo: repeatPassTextField.bottomAnchor, constant: 20),
            haveAccButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            haveAccButton.heightAnchor.constraint(equalToConstant: 29),
            
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            closeButton.widthAnchor.constraint(equalToConstant: 25),
            closeButton.heightAnchor.constraint(equalToConstant: 25),
           
            
        ])
        
    }
    
    @objc func signUpAction() {
        if checkField.validField(loginView, loginTextField),
           checkField.validField(passwordView, passTextField){
            if passTextField.text == repeatPassTextField.text {
                service.createNewUser(LoginField(email: loginTextField.text!, password: passTextField.text!)) { [weak self] code in
                    switch code.code {
                    case 0: print("Register error")
                    case 1: print("Congratulation, all good")
                        self?.service.confirmEnail()
                        let alert = UIAlertController(title: "OK", message: "Success", preferredStyle: .alert)
                        let okButton = UIAlertAction(title: "Good", style: .default) { _ in
                            self?.delegate.closeVc()
//                            closeBar.isHidden = true
                        }
                        alert.addAction(okButton)
                        self?.present(alert, animated: true)
                    default: print("Unknown error")
                    }
                }
            }else {
                print("Bad")
            }
            
        }
    }
    
    @objc func endEgiting() {
        self.view.endEditing(true)
    }
    
    @objc func closeAction() {
        delegate.closeVc()
    }

   
}

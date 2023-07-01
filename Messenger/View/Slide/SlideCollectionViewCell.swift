//
//  SlideCollectionViewCell.swift
//  Messenger
//
//  Created by Ярослав Вербило on 2023-06-20.
//

import UIKit

class SlideCollectionViewCell: UICollectionViewCell {
    
    static let reuseId = "SlideCollectionViewCell"
    
    let backgroundImageView = UIImageView()
    let signUpButton = UIButton()
    let logInButton = UIButton()
    let nameLabel = UILabel()
    let descriptionLabel = UILabel()
    
    var delegate: LoginViewControllerDelegate!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        
        
    }
    
    required init?(coder: NSCoder){
        fatalError("init{coder:) has not been implemented")
    }
    
    func setup () {
        
        [backgroundImageView, signUpButton, logInButton, nameLabel, descriptionLabel].forEach{
            self.contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        
        backgroundImageView.image = UIImage(named: "mainSlide")
        
        
        let attributesSignUp: [NSAttributedString.Key: Any] = [
                    .font: UIFont.systemFont(ofSize: 32, weight: .bold)
                ]
                let attributedTitleSignUp = NSAttributedString(string: "Sign Up", attributes: attributesSignUp)
                signUpButton.setAttributedTitle(attributedTitleSignUp, for: .normal)
        
        
        
        signUpButton.backgroundColor = UIColor(red: 83/255, green: 82/255, blue: 237/255, alpha: 1)
        signUpButton.layer.cornerRadius = 59/2
        signUpButton.setTitleColor(.white, for: .normal)
        signUpButton.isHidden = true
        signUpButton.addTarget(self, action: #selector(signUpAction), for: .touchUpInside)
        
        let attributesLogIn: [NSAttributedString.Key: Any] = [
                    .font: UIFont.systemFont(ofSize: 28, weight: .bold)
                ]
        let attributedTitleLogIn = NSAttributedString(string: "Log In", attributes: attributesLogIn)
        logInButton.setAttributedTitle(attributedTitleLogIn, for: .normal)
        logInButton.setTitleColor(.white, for: .normal)
        logInButton.isHidden = true
        logInButton.addTarget(self, action: #selector(logInAction), for: .touchUpInside)

        
        nameLabel.text = "Regular Chat"
        nameLabel.textColor = .white
//        nameLabel.font = UIFont.boldSystemFont(ofSize: 34)
        nameLabel.font = UIFont.systemFont(ofSize: 34, weight: .bold)
        
        
        descriptionLabel.text = "Lorem omsgs m gsgsgsgsg sg sgnjksngjnjsngjsnjgnjsnjsgnjsnjgnsjgjsjgnjsngjnsjngsjgsjgjsglm"
        descriptionLabel.textColor = UIColor(red: 200/255, green: 214/255, blue: 228/255, alpha: 1)
        descriptionLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        descriptionLabel.numberOfLines = 0
        
        
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: -35),
            backgroundImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            signUpButton.topAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -200),
            signUpButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 57),
            signUpButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -57),
            signUpButton.heightAnchor.constraint(equalToConstant: 59),
            
            logInButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            logInButton.topAnchor.constraint(equalTo: signUpButton.bottomAnchor, constant: 18),
            
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 126),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 48),
            
            descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 150),
            descriptionLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -110),

        ])
    }
    
    
    func configure(slide: Slides) {
        backgroundImageView.image = slide.img
        descriptionLabel.text = slide.text
        if slide.id == 3 {
            signUpButton.isHidden = false
            logInButton.isHidden = false
        }
    }

    @objc func signUpAction() {
        delegate.openRegVc()
    }

    @objc func logInAction() {
        delegate.openAuthVc()
    }
}

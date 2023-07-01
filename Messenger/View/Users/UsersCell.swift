//
//  UsersCell.swift
//  Messenger
//
//  Created by Ярослав Вербило on 2023-06-25.
//

import UIKit


class UsersCell: UITableViewCell {
    
    static let reuseId = "UsersCell"
    
    let avatar = UIImageView()
    
    let emailLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "Hhfhf"
        return label
    }()
    
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()

        avatar.image = UIImage(named: "mainSlide")
        avatar.contentMode = .scaleToFill
        avatar.layer.cornerRadius = 25
//        avatar.layer.borderColor = UIColor.red.cgColor
//        avatar.layer.borderWidth = 10
        avatar.layer.masksToBounds = true
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func conficugeCell(_ name: String) {
        emailLabel.text = name
    }
    
    private func setupCell() {
        [avatar, emailLabel].forEach{
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        NSLayoutConstraint.activate([
//            avatar.topAnchor.constraint(equalTo: contentView.topAnchor, constant:  16),
            avatar.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
//            avatar.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 25),
            avatar.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            avatar.heightAnchor.constraint(equalToConstant: 50),
            avatar.widthAnchor.constraint(equalToConstant: 50),
            
//            emailLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            emailLabel.leadingAnchor.constraint(equalTo: avatar.trailingAnchor, constant: 20),
            emailLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            emailLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            
                        
        ])
    }
    
    
}

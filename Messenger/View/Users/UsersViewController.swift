//
//  UsersViewController.swift
//  Messenger
//
//  Created by Ярослав Вербило on 2023-06-25.
//

import UIKit



class UsersViewController: UIViewController {
    
    var tableView = UITableView()
    let service = Service.shared
    var users = [CurrentUser]()
    
        override func viewDidLoad() {
            super.viewDidLoad()
            
            getUsers()
            
            
            tableView = UITableView(frame: view.bounds, style: .plain)
            tableView.delegate = self
            tableView.dataSource = self
            tableView.separatorStyle = .none
            tableView.separatorColor = .blue
            tableView.backgroundColor = .gray
            tableView.separatorColor = UIColor.clear
            tableView.tableFooterView = UIView()
            view.addSubview(tableView)
            tableView.register(UsersCell.self, forCellReuseIdentifier: UsersCell.reuseId)
        }
    
    func getUsers() {
        service.getAllUsers { users in
            self.users = users
            self.tableView.reloadData()
        }
    }
    
}


extension UsersViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UsersCell.reuseId, for: indexPath) as? UsersCell
        else { fatalError() }
        cell.selectionStyle = .none
        cell.layer.cornerRadius = 50
        cell.layer.borderColor = UIColor.gray.cgColor
        cell.layer.borderWidth = 10
        cell.backgroundColor = .green
        let cellName = users[indexPath.row]
        cell.conficugeCell(cellName.email)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let userId = users[indexPath.row].id
        
        let vc = ChatViewController()
        vc.otherId = userId
        print(userId)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

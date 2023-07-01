//
//  MessagesViewController.swift
//  Messenger
//
//  Created by Ярослав Вербило on 2023-06-26.
//

import UIKit
import MessageKit


class MessageViewController: UIViewController {
    
    var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView = UITableView(frame: view.bounds, style: .plain)
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        
        
//        view.backgroundColor = .green
        navigationItem.title = "Messages"
       
    }
}


extension MessageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "Jony"
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ChatViewController()
        vc.chatId = "firstChatId"
        vc.otherId = "0yqbRpiVcSSDkwH9Gwj4kTdI7Mx2"
        navigationController?.pushViewController(vc, animated: true)
    }
    
}






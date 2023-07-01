//
//  ChatViewController.swift
//  Messenger
//
//  Created by Ярослав Вербило on 2023-06-26.
//

import UIKit
import MessageKit
import InputBarAccessoryView

struct Sender: SenderType {
    var senderId: String
    var displayName: String
}

struct Message: MessageType {
    var sender: MessageKit.SenderType
    var messageId: String
    var sentDate: Date
    var kind: MessageKit.MessageKind
}

class ChatViewController: MessagesViewController {
    
    var chatId: String?
    var otherId: String?
    let service = Service.shared
    
    let selfSender = Sender(senderId: "1", displayName: "")
    let otherSender = Sender(senderId: "2", displayName: "")
    
    var messages = [Message]()
//    var messag: [MessageType] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        
        messagesCollectionView.backgroundColor = UIColor(red: 128/255, green: 128/255, blue: 128/255, alpha: 1)
        messagesCollectionView.tintColor = .yellow
        messagesCollectionView.tintColorDidChange()
        messageInputBar.backgroundView.backgroundColor = UIColor(red: 128/255, green: 128/255, blue: 128/255, alpha: 1)
        
        messageInputBar.delegate = self
        showMessageTimestampOnSwipeLeft = true
//        messagesCollectionView.reloadData()
        
        
        if chatId == nil {
            service.getConvoId(otherId: otherId!) { [weak self] chatId in
                self?.chatId = chatId
                
                self?.getMessages(convoId: chatId)
            }
        }
        
        
        
    }
    
    func getMessages(convoId: String) {
        service.getAllMessages(chatId: convoId) { [weak self] messages in
            self?.messages = messages
            self?.messagesCollectionView.reloadDataAndKeepOffset()
        }
    }
   
}


extension ChatViewController: MessagesDisplayDelegate, MessagesLayoutDelegate, MessagesDataSource {
    var currentSender: MessageKit.SenderType {
        return selfSender
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessageKit.MessagesCollectionView) -> MessageKit.MessageType {
        return messages[indexPath.section]
    }
    
    func numberOfSections(in messagesCollectionView: MessageKit.MessagesCollectionView) -> Int {
        return messages.count
    }
    
    
    
}


extension ChatViewController: InputBarAccessoryViewDelegate {
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
        let msg = (Message(sender: selfSender, messageId: "", sentDate: Date(), kind: .text(text)))
        messages.append(msg)
        service.sendMessage(otherId: self.otherId, convoId: self.chatId, text: text) { [weak self] convoId in
            DispatchQueue.main.async {
                inputBar.inputTextView.text = nil
                self?.messagesCollectionView.reloadDataAndKeepOffset()
            }
            
            self?.chatId = convoId
        }
        
    }
}


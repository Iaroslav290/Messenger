//
//  Service.swift
//  Messenger
//
//  Created by Ярослав Вербило on 2023-06-22.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

class Service{
    static let shared = Service()
    
    init() {}
    
    
    func createNewUser(_ data: LoginField, completion: @escaping (ResponseCode) -> ()) {
        Auth.auth().createUser(withEmail: data.email, password: data.password) { result, error in
            if error == nil {
                if result != nil {
                    let userId = result?.user.uid
                    let email = data.email
                    let data: [String: Any] = ["email": email]
                    
                    Firestore.firestore().collection("users").document(userId!).setData(data)
                    completion(ResponseCode(code: 1))
                }
            } else {
                completion(ResponseCode(code: 0))
            }
        }
    }
    
    func confirmEnail() {
        Auth.auth().currentUser?.sendEmailVerification(completion: { err in
            if err != nil {
                print(err!.localizedDescription)
            }
        })
    }
    
    func authInApp(_ data: LoginField, completion: @escaping (AuthResponce) -> ()) {
        Auth.auth().signIn(withEmail: data.email, password: data.password) { result, err in
            if err != nil {
                completion(.error)
            } else {
                if let result = result {
                    if result.user.isEmailVerified {
                        completion(.success)
                    } else{
                        self.confirmEnail()
                        completion(.noVerify)
                    }
                }
            }
        }
    }
    
    func getUserStatus() {
        
    }
    
    func getAllUsers(completion: @escaping ([CurrentUser]) -> ()) {
        
        guard let email = Auth.auth().currentUser?.email else { return }
        
        var currentUser = [CurrentUser]()
        Firestore.firestore().collection("users")
            .whereField("email", isNotEqualTo: email)
            .getDocuments { snap, err in // we can add addSnapshotListener (not getDocuments, and data will reload automaticaly in real time, it will eat more memory but will update users infofnation in real time
                if err == nil {
                    var emailList = [String]()
                    if let docs = snap?.documents{
                        for doc in docs {
                            let data = doc.data()
                            let userId = doc.documentID
                            let email = data["email"] as! String
                            
                            currentUser.append(CurrentUser(id: userId, email: email))
                        }
                    }
                    completion(currentUser)
                }
            }
    }
    
    //MARK: == Messager
    
    
    func sendMessage(otherId: String?, convoId: String?, text: String, completion: @escaping (String) -> ()) {
        
        let ref = Firestore.firestore()
        if let uid = Auth.auth().currentUser?.uid {
            if convoId == nil {
                // create new
                let convoId = UUID().uuidString
                
                let selfData: [String: Any] = [
                    "date": Date(),
                    "otherId": otherId!
                    
                ]
                
                let otherData: [String: Any] = [
                    "date": Date(),
                    "otherId": uid
                    
                ]
                
                ref.collection("users")
                    .document(uid)
                    .collection("conversations")
                    .document(convoId)
                    .setData(selfData)
                
                
                ref.collection("users")
                    .document(otherId!)
                    .collection("conversations")
                    .document(convoId)
                    .setData(otherData)
                
                
                let msg: [String: Any] = [
                    "date": Date(),
                    "sender": uid,
                    "text": text
                ]
                
                let convoInfo: [String: Any] = [
                    "date": Date(),
                    "selfSender": uid,
                    "otherSender": otherId
                ]
                
                ref.collection("conversations")
                    .document(convoId)
                    .setData(convoInfo) { err in
                        if let err = err {
                            print(err.localizedDescription)
                            return
                        }
                        
                        ref.collection("conversations")
                            .document(convoId)
                            .collection("messages")
                            .addDocument(data: msg) { err in
                                if err == nil {
                                    completion(convoId)
                                }
                            }
                    }
                
            } else {
                let msg: [String: Any] = [
                    "date": Date(),
                    "sender": uid,
                    "text": text
                ]
                ref.collection("conversations").document(convoId!).collection("messages").addDocument(data: msg) { err in
                    if err == nil {
                        completion(convoId!)
                    }
                }
            }
        }
        
        
        
    }
    
    func updateConve() {
        
    }
    
    func getConvoId(otherId: String, completion: @escaping (String) -> ()) {
        if let uid = Auth.auth().currentUser?.uid {
            let ref = Firestore.firestore()
            
            ref.collection("users")
                .document(uid)
                .collection("conversations")
                .whereField("otherId", isEqualTo: otherId)
                .getDocuments { snap, err in
                    if let err = err {
                        return
                    }
                    
                    if let snap = snap, !snap.documents.isEmpty {
                        let doc = snap.documents.first
                        if let convoId = doc?.documentID {
                            completion(convoId)
                        }
                    }
                }
        }
    }
    
    func getAllMessages(chatId: String, completion: @escaping ([Message]) -> ()) {
        if let uid = Auth.auth().currentUser?.uid {
            let ref = Firestore.firestore()
            ref.collection("conversations")
                .document(chatId)
                .collection("messages")
                .limit(to: 50)
                .order(by: "date", descending: false)
                .addSnapshotListener { snap, err in
                    if err != nil {
                        return
                    }
                    
                    if let snap = snap, !snap.documents.isEmpty{
                        var msgs = [Message]()
                        var sender = Sender(senderId: uid, displayName: "Me")
                        for doc in snap.documents{
                            let data = doc.data()
                            let userId = data["sender"] as! String
                            
                            let messageId = doc.documentID
                            
                            let date = data["date"] as! Timestamp
                            let sentDate = date.dateValue()
                            let text = data["text"] as! String
                            
                            if userId == uid {
                                sender = Sender(senderId: "1", displayName: "")
                            } else {
                                sender = Sender(senderId: "2", displayName: "")
                            }
                            
                            msgs.append(Message(sender: sender, messageId: messageId, sentDate: sentDate, kind: .text(text)))
                        }
                        completion(msgs)
                    }
                }
        }
    }
    func getOneMessage() {
            
    }
}


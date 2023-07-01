//
//  Model.swift
//  Messenger
//
//  Created by Ярослав Вербило on 2023-06-21.
//

import UIKit

enum AuthResponce {
    case success, noVerify, error
}

struct Slides {
    var id: Int
    var text: String
    var img: UIImage
}

struct LoginField {
    var email: String
    var password: String
}

struct ResponseCode {
    var code: Int
}

struct CurrentUser {
    var id: String
    var email: String
}

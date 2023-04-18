//
//  DetailProtocol.swift
//  taskCoreData
//
//  Created by admin on 18.04.2023.
//

import Foundation

protocol DetailProtocolView: AnyObject {
    var user: User? { get set }
    func updateUserInfo()
}

protocol DetailPresenterProtocol {
    init(view: DetailProtocolView, user: User)
    func getUser()
    func updateUser(avatar: Data, name: String, gender: String, dateBorn: String)
}

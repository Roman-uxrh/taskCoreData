//
//  MainProtocol.swift
//  taskCoreData
//
//  Created by admin on 18.04.2023.
//

import Foundation

protocol MainProtocolView: AnyObject {
    func reloadTable()
}

protocol MainPresenterProtocol {
    init(view: MainProtocolView)
    func addNewUser(name: String)
    func fetchUsers()
    func getUsersCount() -> Int
    func getUser(index: Int) -> User?
    func deleteUser(index: Int)
}

//
//  ListUsersPresenter.swift
//  taskCoreData
//
//  Created by admin on 18.04.2023.
//

import Foundation

final class MainPresenter: MainPresenterProtocol {
    
    weak var view: MainProtocolView?
    
    init(view: MainProtocolView) {
        self.view = view
    }
    
    func addNewUser(name: String) {
        CoreDataManager.shared.addNewUser(name: name, gender: "male", dateBorn: "01.01.1900")
        view?.reloadTable()
    }
    
    func fetchUsers() {
        CoreDataManager.shared.fetchUsers()
        view?.reloadTable()
    }
    
    func getUsersCount() -> Int {
        CoreDataManager.shared.users?.count ?? 0
    }
    
    func getUser(index: Int) -> User? {
        CoreDataManager.shared.users?[index]
    }
    
    func deleteUser(index: Int) {
        CoreDataManager.shared.deleteUser(index: index)
        view?.reloadTable()
    }
    
}

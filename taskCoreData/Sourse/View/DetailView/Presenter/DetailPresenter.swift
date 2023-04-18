//
//  File.swift
//  taskCoreData
//
//  Created by admin on 18.04.2023.
//

import Foundation

final class DetailPresenter: DetailPresenterProtocol {
    weak var view: DetailProtocolView?
    private var user: User?

    init(view: DetailProtocolView, user: User) {
        self.view = view
        self.user = user
    }
    
    func getUser() {
        view?.user = user
    }

    func updateUser(avatar: Data, name: String, gender: String, dateBorn: String) {
        user?.avatar = avatar
        user?.name = name
        user?.gender = gender
        user?.dateBorn = dateBorn
        CoreDataManager.shared.updateUser()
    }
}

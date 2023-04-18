//
//  Entity.swift
//  taskCoreData
//
//  Created by admin on 14.04.2023.
//

import Foundation
import CoreData

final class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    var users: [User]?
    
    // Контейнер
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "taskCoreData")
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    // Контекст
    private lazy var context: NSManagedObjectContext = {
        return persistentContainer.viewContext
    }()
    
    // Функция сохранения контекста
    private func saveContext () {
        let context = persistentContainer.viewContext
        
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    // Функция выполняет запрос к базе данных CoreData на получение списка юзеров и присваивает их массиву юзеров
    func fetchUsers() {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()

        do {
            users = try context.fetch(fetchRequest)
        } catch {
            print(error)
        }
    }
    
    // Функция добавления нового юзера
    func addNewUser(name: String, gender: String, dateBorn: String) {
        let user = User(context: context)
        user.name = name
        user.gender = gender
        user.dateBorn = dateBorn
        updateUser()
    }
    
    // Функция удаления юзера
    func deleteUser(index: Int) {
        guard let user = users?[index] else { return }
        
        context.delete(user)
        updateUser()
    }
    
    // Функция обновления, сохраняет и обновляет массив юзеров
    func updateUser() {
        saveContext()
        fetchUsers()
    }
}

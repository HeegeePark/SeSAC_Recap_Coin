//
//  BaseRepository.swift
//  SeSAC_Recap_Coin
//
//  Created by 박희지 on 2/28/24.
//

import Foundation
import RealmSwift

class BaseRepository<T: Object> {
    typealias Model = T
    private let realm = try! Realm()
    
    func createItem(_ item: Model) {
        do {
            try realm.write {
                realm.add(item)
            }
        } catch {
            print(error)
        }
    }
    
    func fetch() -> Results<Model> {
        return realm.objects(Model.self)
    }
    
    func fetchSorted(results: Results<Model>, _ key: String) -> Results<Model> {
        return results.sorted(byKeyPath: key, ascending: true)
    }
    
    func fetchFiltered(results: Results<Model>, key: String, value: String) -> Results<Model> {
        return results.filter("\(key) == '\(value)'")
    }
    
    func updateItem(id: ObjectId, updated: Model) {
    }
    
    func deleteItem(object: ObjectBase) {
        do {
            try realm.write {
                realm.delete(object)
            }
        } catch {
            print(error)
        }
    }
}

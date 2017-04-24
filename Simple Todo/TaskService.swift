//
//  TaskService.swift
//  Simple Todo
//
//  Created by Khoi Lai on 4/24/17.
//  Copyright © 2017 khoi.io. All rights reserved.
//

import Foundation
import RxSwift
import RealmSwift
import RxRealm

struct TaskService: TaskServiceType {
    private let config: Realm.Configuration
    private let realm: Realm

    init(syncConfig: SyncConfiguration) throws {
        config = Realm.Configuration(syncConfiguration: syncConfig)
        realm = try Realm(configuration: config)
    }

    fileprivate func withRealm<T>(_ operation: String, action: (Realm) throws -> T) -> T? {
        do {
            return try action(realm)
        } catch let err {
            log.error("Failed \(operation) realm with error: \(err)")
            return nil
        }
    }

    func create(task: Task) -> Observable<Task> {
        let result = withRealm("Creating Task") { (realm) -> Observable<Task> in
            try realm.write {
                realm.add(task)
            }
            return .just(task)
        }

        return result ?? .error(TaskServiceError.creationFailed)
    }

    func tasks() -> Observable<Results<Task>> {
        let result = withRealm("Getting Tasks") { (realm) -> Observable<Results<Task>> in
            let tasks = realm.objects(Task.self)
            return Observable.collection(from: tasks)
        }
        return result ?? .empty()
    }

    func toggle(task: Task) -> Observable<Task> {
        let result = withRealm("Toggling Task") { (realm) -> Observable<Task> in
            try realm.write {
                if task.completedDate == nil {
                    task.completedDate = Date()
                } else {
                    task.completedDate = nil
                }
            }
            return .just(task)
        }
        return result ?? .error(TaskServiceError.toggleFailed(task))
    }
}
